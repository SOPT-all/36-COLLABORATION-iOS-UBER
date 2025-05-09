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
        view.backgroundColor = .white
        view.addSubview(helloLabel)

        helloLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let helloLabel = UILabel().then {
        $0.text = "우버들아 안뇽 붕붕"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .center
    }
}
