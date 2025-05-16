//
//  UberNavigationBar.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/16/25.
//

import UIKit

import SnapKit

final class UberNavigationBar: UIView {
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(resource: .backButton), for: .normal)        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)    
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        addSubviews(backButton)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(18)
        }
    }
}
