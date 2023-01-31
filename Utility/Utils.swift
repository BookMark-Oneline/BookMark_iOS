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

//MARK: - UIImageView extension: Image URL 로드용
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func setImageUrl(url: String) {
        let imgURL = URL(string: url)
        self.load(url: imgURL!)
    }
}

// MARK: - Tab bar hidden 용 extension
extension UINavigationController {
    func pushViewControllerTabHidden(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        self.pushViewController(viewController, animated: animated)
    }
}

// MARK: - navigation controller custom
extension UIViewController {
    func setNavigationCustom(title: String, tintColor: UIColor) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setNavigationImageButton(imageName: [String], action: [Selector]) {
        var arr: [UIBarButtonItem] = []
        for i in 0..<imageName.count {
            let btn = UIBarButtonItem(image: UIImage(named: imageName[i]), style: .plain, target: self, action: action[i])
            btn.width = 27
            arr.insert(btn, at: arr.startIndex)
        }
        
        self.navigationItem.rightBarButtonItems = arr
    }
    
    func setNavigationLabelButton(title: String, action: Selector) {
        let btn = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        btn.tintColor = .textOrange
        
        self.navigationItem.rightBarButtonItem = btn
    }
}
