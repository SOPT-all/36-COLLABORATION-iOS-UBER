//
//  PickupTimeViewController.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/19/25.
//

import UIKit
import SnapKit
import Then

final class PickupTimeViewController: UIViewController {
    
    // MARK: - UI Components

    private let titleLabel = UILabel().then {
        $0.text = "픽업 시간"
        $0.font = .title1_eb32
        $0.textColor = .primary
        $0.textAlignment = .left
    }

    private let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .dateAndTime
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    private let arrivalLabel = UILabel().then {
        $0.text = "도착 시간 12:30 pm KST"
        $0.font = .body2_eb16
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let infoLabel = UILabel().then {
        $0.text = "약 25분 소요 예상"
        $0.font = .caption_b12
        $0.textColor = .gray
        $0.textAlignment = .center
    }

    private let footerLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2

        let text = """
        예상 교통 상황을 바탕으로 한 예상 시간입니다. 실제 교통량에 따라 도착 시간이 변경될 수 있습니다. 픽업 1시간 전까지 또는 기사님이 배정되기 전까지는 취소 수수료가 부과되지 않습니다. 약관보기
        """
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))

        $0.attributedText = attributedString
        $0.font = .caption_m12
        $0.textColor = .gray
        $0.numberOfLines = 0
    }

    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.applyUberStyle()
    }

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        setBindings()
    }

    // MARK: - Configure
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubviews(titleLabel, datePicker, arrivalLabel, infoLabel, footerLabel, nextButton)
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(14)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }

        arrivalLabel.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(arrivalLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }

        footerLabel.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }

    // MARK: - Bindings

    private func setBindings() {
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }()

    @objc private func dateChanged(_ sender: UIDatePicker) {
        let formatted = Self.dateFormatter.string(from: sender.date)
        arrivalLabel.text = "도착 시간 \(formatted) KST"
    }
}
