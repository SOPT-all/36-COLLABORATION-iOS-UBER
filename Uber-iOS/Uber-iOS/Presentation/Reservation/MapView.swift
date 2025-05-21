//
//  MapView.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/22/25.
//

import UIKit
import MapKit

import SnapKit

final class MapView: UIView {
    private var mapView: MKMapView!
    private var start: CLLocationCoordinate2D?
    private var end: CLLocationCoordinate2D?
    private var polyline: MKPolyline?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initMapView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.isUserInteractionEnabled = false
        mapView.showsUserLocation = false
        mapView.mapType = .mutedStandard
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.showsTraffic = false
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(LocationAnnotationView.self))
        let center = CLLocationCoordinate2D(latitude: 37.55782517284962, longitude: 127.00096200411859)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        mapView.setRegion(region, animated: true)
    }
    
    private func setLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
    
    private func setupAnnotationView(for annotation: LocationAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(LocationAnnotationView.self), for: annotation)
    }
    
    private func getRoute() {
        guard let start, let end else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .automobile
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            let startLocation = try await reverseGeoCoding(location: start)
            let endLocation = try await reverseGeoCoding(location: end)
            if let result = response?.routes.first {
                mapView.addOverlay(result.polyline)
                let startAnnotation = LocationAnnotation(coordinate: start, location: startLocation)
                let endAnnotation = LocationAnnotation(coordinate: end, location: endLocation)                
                
                mapView.addAnnotation(startAnnotation)
                mapView.addAnnotation(endAnnotation)
                self.mapView.setVisibleMapRect(result.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
            }
        }
    }
    
    func setCoordinator(_ start: CLLocationCoordinate2D, _ end: CLLocationCoordinate2D) {
        self.start = start
        self.end = end
        getRoute()
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline
        else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
        renderer.strokeColor = .black
        renderer.lineWidth = 4.0
        renderer.alpha = 1.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        
        if let locationAnnotation = annotation as? LocationAnnotation {
            annotationView = setupAnnotationView(for: locationAnnotation, on: mapView)
        }
        
        return annotationView
    }
}

extension MapView {
    func reverseGeoCoding(location: CLLocationCoordinate2D) async throws  -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        do {
            let result = try await geoCoder.reverseGeocodeLocation(location)
            let city = result.last?.administrativeArea
            let state = result.last?.subLocality
            if let state {
                return state
            } else if let city {
                return city
            }
        } catch {
            throw error
        }
        return ""
    }
}
