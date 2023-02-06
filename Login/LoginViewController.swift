//
//  LoginViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/06.
//

import UIKit

// MARK: - 로그인 뷰 컨트롤러
class LoginViewController: UIViewController {

    let loginView = LoginView()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.initViews(self.view)
        loginView.btn_appleLogin.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
    }
    
    // MARK: - todo: 로그인 처리
    @objc func didTapLoginBtn(_ sender: UIButton) {
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
