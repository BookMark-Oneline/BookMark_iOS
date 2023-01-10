//
//  Utils.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import Foundation
import UIKit

// MARK: - view extension
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
