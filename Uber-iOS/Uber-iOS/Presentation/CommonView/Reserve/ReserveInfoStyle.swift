//
//  ReserveInfoStyle.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/15/25.
//

import UIKit

enum ReserveInfoStyle {
    case info(icon: UIImage?, title: String, subtitle: String)
    case inactive(icon: UIImage?, title: String, subtitle: String)
    case active(
        icon: UIImage?,
        title: String,
        subtitle: String,
        additionalViews: [UIView]
    )
}
