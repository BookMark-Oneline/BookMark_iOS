//
//  Utils.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

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
        guard let url = imgURL else {return}
        self.load(url: url)
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
    func setNavigationCustom(title: String, tintColor: UIColor = .black) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = tintColor
        //self.navigationController?.navigationBar.isTranslucent = false
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

// MARK: - UIButton extension
extension UIButton {
    func setTitle(_ title: String, size: CGFloat, weight: UIFont.Weight, color: UIColor, when: UIControl.State = .normal) {
        if #available(iOS 15.0, *) {
            var attributedTitle = AttributedString(title)
            attributedTitle.font = .suit(size: size, weight: weight)
            attributedTitle.foregroundColor = color
            var configuration = self.configuration ?? .plain()
            configuration.attributedTitle = attributedTitle
            self.configuration = configuration
        } else {
            self.setTitle(title, for: when)
            self.titleLabel?.font = .systemFont(ofSize: size, weight: weight)
            self.setTitleColor(color, for: when)
        }
    }
}

// MARK: - UILabel extension
extension UILabel {
    func setTxtAttribute(_ title: String, size: CGFloat, weight: UIFont.Weight, txtColor: UIColor) {
        self.text = title
        self.font = .suit(size: size, weight: weight)
        self.textColor = txtColor
    }
}

// MARK: - UIFont extension
extension UIFont {
    static func suit(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "SUIT"

        var weightString: String
        switch weight {
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }

        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}

extension UIFont.Weight {
    /// regular
    static var w400: UIFont.Weight { .regular }
    /// medium
    static var w500: UIFont.Weight { .medium }
    /// semibold
    static var w600: UIFont.Weight { .semibold }
    /// bold
    static var w700: UIFont.Weight { .bold }
}
