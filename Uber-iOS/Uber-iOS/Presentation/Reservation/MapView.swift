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
    var mapView: MKMapView!
    
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
    }
    
    private func setLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
}

extension MapView: MKMapViewDelegate {
    
}
