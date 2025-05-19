//
//  ReserveBannerView.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/15/25.
//
import UIKit
import SnapKit
import Then

final class ReserveBannerView: UIView {
    
    // MARK: - UI Components
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.bgWhite
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.bgGray.cgColor
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    private let bannerImageView = UIImageView().then {
        $0.image = UIImage(named: "banner")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "미리 예약하고 걱정을\n내려놓으세요"
        $0.font = UIFont.title3_eb20
        $0.textColor = UIColor.primary
        $0.numberOfLines = 2
    }
    
    private let reserveButton = UIButton().then {
        $0.setTitle("Reserve 이용해보기", for: .normal)
        $0.setTitleColor(UIColor.primary, for: .normal)
        $0.titleLabel?.font = UIFont.body3_m14
        $0.backgroundColor = UIColor.bgWhite
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.iconInactive.cgColor
        $0.clipsToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        applyTitleLineStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubviews(titleLabel, reserveButton, bannerImageView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalTo(153)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(bannerImageView.snp.leading)
        }
        
        reserveButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(37)
        }
    }
    
    // MARK: - Style

    private func applyTitleLineStyle() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 30
        paragraphStyle.maximumLineHeight = 30
        paragraphStyle.lineBreakMode = .byWordWrapping

        let attributedText = NSAttributedString(
            string: "미리 예약하고 걱정을\n내려놓으세요",
            attributes: [
                .paragraphStyle: paragraphStyle,
                .kern: -0.8
            ]
        )

        titleLabel.attributedText = attributedText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reserveButton.layer.cornerRadius = 18.5
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        reserveButton.backgroundColor = .bgBlack
        reserveButton.setTitleColor(.white, for: .normal)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        reserveButton.backgroundColor = .bgWhite
        reserveButton.setTitleColor(.primary, for: .normal)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        reserveButton.backgroundColor = .bgWhite
        reserveButton.setTitleColor(.primary, for: .normal)
    }
}
