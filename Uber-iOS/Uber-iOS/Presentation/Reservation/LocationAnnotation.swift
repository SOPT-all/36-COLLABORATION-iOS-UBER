//
//  LocationAnnotation.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/22/25.
//

import UIKit
import MapKit

import SnapKit

final class LocationAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    let location: String
    
    init(coordinate: CLLocationCoordinate2D, location: String) {
        self.coordinate = coordinate
        self.location = location
    }
}

final class LocationAnnotationView: MKAnnotationView {
    
    private let locationLabel = UILabel().then {
        $0.text = "김포공항"
        $0.font = .caption_m12
        $0.textColor = .sub1
    }
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(resource: .rightIcon)
    }
    
    private let containreView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        locationLabel.text = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? LocationAnnotation else { return }
        
        locationLabel.text = annotation.location
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelSize = locationLabel.intrinsicContentSize
        let imageSize = imageView.intrinsicContentSize
        
        let width = labelSize.width + imageSize.width + (9 * 2)
        let height = labelSize.height + (8 * 2)
        self.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
    }
    
    private func setLayout() {
        backgroundColor = .white
        
        containreView.addSubviews(locationLabel, imageView)
        addSubview(containreView)
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(locationLabel.snp.trailing).offset(9)
        }
        
        containreView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(9)
        }
    }
}
