//
//  ViewController.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/8/25.
//

import SnapKit
import Then
import UIKit

final class ViewController: BaseViewController {
    
    // MARK: - UI Components

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

    private let locationService = LocationService()

    // MARK: - LifeCycle

    override func configure() {
        super.configure()
        addSubviews(departureField, arrivalField, helloLabel, subLabel)

        departureField.textField.delegate = self
        arrivalField.textField.delegate = self

        departureField.textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEndOnExit)
        arrivalField.textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEndOnExit)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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

    // MARK: - API 요청 및 화면 전환

    @objc private func textFieldDidEndEditing() {
        guard
            let departure = departureField.textField.text, !departure.isEmpty,
            let arrival = arrivalField.textField.text, !arrival.isEmpty,
            departure != arrival
        else {
            showAlert(message: "출발지와 도착지를 올바르게 입력해주세요.")
            return
        }

        Task {
            do {
                try await locationService.sendLocation(departures: departure, destination: arrival)
                print("🥳 출발지/도착지 전송 성공")
                showAlert(message: "출발지와 도착지가 성공적으로 저장되었습니다.") {
                    self.moveToPickerTimeView()
                }
            } catch {
                print("😱 에러 발생: \(error.localizedDescription)")
                showAlert(message: "요청 중 오류가 발생했습니다.\n다시 시도해주세요.")
            }
        }
    }

    private func moveToPickerTimeView() {
        let pickerVC = PickupTimeViewController()
        self.navigationController?.pushViewController(pickerVC, animated: true)
    }

    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldDidEndEditing()
        return true
    }
}

#Preview {
    ViewController()
}
