//
//  ViewController.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/8/25.
//

import SnapKit
import Then
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = UIColor.bgBlack
        
        [helloLabel, subLabel].forEach { view.addSubview($0) }

        helloLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(helloLabel.snp.bottom).offset(4)
        }
    }

    private let helloLabel = UILabel().then {
        $0.text = "우버들아 안뇽 붕붕"
        $0.textColor = UIColor.point2
        $0.font = UIFont.title1_eb32
        $0.textAlignment = .center
    }
    
    private let subLabel = UILabel().then {
        $0.text = "앞으로 잘해보자"
        $0.textColor = UIColor.textWhite
        $0.font = UIFont.caption_m12
        $0.textAlignment = .center
    }
}
