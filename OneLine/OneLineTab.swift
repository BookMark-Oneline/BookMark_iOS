//
//  OneLineTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit

// MARK: - 오늘 한줄 탭
class OneLineTab: UIViewController {
    let oneLineView = OneLineTabView()
    
    var txtUserData: String = "사랑에는 늘 약간의 망상이 들어 있다.\n\n차라투스트라는 이렇게 말했다, 프리드리히 니체"
    var imgUserData: UIImage? = UIImage(named: "backImg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        oneLineView.initViews(self.view)
        oneLineView.btn_create.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        oneLineView.btn_more.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        reload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func reload() {
        self.oneLineView.img_background.image = self.imgUserData
        self.oneLineView.label_oneline.text = self.txtUserData
    }
}

// MARK: - button event extension
extension OneLineTab {
    @objc func didTapCreateButton(_ sender: UIButton) {
        self.navigationController?.pushViewControllerTabHidden(CreateOneLineViewController(), animated: true)
    }
    
    @objc func didTapMoreButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "도움말", preferredStyle: .actionSheet)
        let report = UIAlertAction(title: "신고하기", style: .default, handler: { _ in
            self.view.makeToast("신고되었습니다", duration: 1.5, point: CGPoint(x: ((self.tabBarController?.tabBar.frame.minX ?? 0) + (self.tabBarController?.tabBar.frame.maxX ?? 0)) / 2, y: (self.tabBarController?.tabBar.frame.minY ?? 0) - ((self.tabBarController?.tabBar.frame.height ?? 0)) - 30), title: nil, image: nil, completion: nil)
        })
        let remove = UIAlertAction(title: "삭제하기", style: .default, handler: { _ in
            // MARK: - todo 삭제 로직 구현
            
            self.view.makeToast("삭제되었습니다", duration: 1.5, point: CGPoint(x: ((self.tabBarController?.tabBar.frame.minX ?? 0) + (self.tabBarController?.tabBar.frame.maxX ?? 0)) / 2, y: (self.tabBarController?.tabBar.frame.minY ?? 0) - ((self.tabBarController?.tabBar.frame.height ?? 0)) - 30), title: nil, image: nil, completion: nil)
        })
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(report)
        alert.addAction(remove)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}
