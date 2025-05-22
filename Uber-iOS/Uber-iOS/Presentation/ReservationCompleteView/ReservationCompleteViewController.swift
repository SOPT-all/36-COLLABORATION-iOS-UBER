//
//  ReservationCompleteViewController.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/22/25.
//

import UIKit

final class ReservationCompleteViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view = ReservationCompleteView()
    }
}

extension ReservationCompleteViewController: UberNavigationConfigurable {
    var uberTitle: String? {
        "예약 정보"
    }
}
