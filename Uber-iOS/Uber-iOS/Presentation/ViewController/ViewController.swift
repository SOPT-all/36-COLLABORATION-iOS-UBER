//
//  ViewController.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/8/25.
//

import SnapKit
import Then
import UIKit

class ViewController: BaseViewController {
    
    private let departureField = SearchLocationTextField(
        icon: UIImage(named: "departure"),
        placeholder: "출발지 검색"
    )

    private let arrivalField = SearchLocationTextField(
        icon: UIImage(named: "place"),
        placeholder: "도착지 검색"
    )

    private let helloLabel = UILabel().then {
        $0.text = "우버들아 안뇽 붕붕"
        $0.textColor = UIColor.point2
        $0.font = UIFont.title1_eb32
        $0.textAlignment = .center
    }
    
    private let subLabel = UILabel().then {
        $0.text = "앞으로 잘해보자"
        $0.textColor = UIColor.primary
        $0.font = UIFont.caption_m12
        $0.textAlignment = .center
    }
    
    override func configure() {
        super.configure()
        addSubviews(departureField, arrivalField, helloLabel, subLabel)
    }
    
    override func setConstraints() {
        departureField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }

        arrivalField.snp.makeConstraints {
            $0.top.equalTo(departureField.snp.bottom).offset(8)
            $0.leading.trailing.height.equalTo(departureField)
        }
        
        helloLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(helloLabel.snp.bottom).offset(4)
        }
    }
}

