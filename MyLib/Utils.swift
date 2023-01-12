//
//  Utils.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import Foundation
import UIKit
import SnapKit

// MARK: - view extension
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

// MARK: - UIScrollView extension: 동적 크기 계산용
extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+50)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
    
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        return totalRect.union(view.frame)
    }
}

// MARK: - NavigationController extension
extension UINavigationController {
    func setBasicSettings(title: String = "") {
    }
}
