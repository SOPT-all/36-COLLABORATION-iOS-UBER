//
//  ReservationCompleteView.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/22/25.
//

import UIKit
import SnapKit
import Then
import SwiftUI

final class ReservationCompleteView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "성공적으로 예약이 완료되었습니다"
        $0.textColor = .primary
        $0.font = .title3_eb20
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "예약내역에서 상세 내역을 확인하세요"
        $0.textColor = .sub2
        $0.font = UIFont.body2_m16
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "Complete")
        $0.contentMode = .scaleAspectFit
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("예약 내역 보러 가기", for: .normal)
        $0.applyUberStyle()
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubviews(titleLabel, subtitleLabel, imageView, nextButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(113)
            $0.leading.trailing.equalToSuperview().inset(58)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(259)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}

#Preview {
    ReservationCompleteView()
}
