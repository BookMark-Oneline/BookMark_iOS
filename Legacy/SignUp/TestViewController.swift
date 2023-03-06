//
//  TestViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/15.
//

import UIKit

class TestViewController: UIViewController {

    let btn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(btn)
        btn.snp.makeConstraints() { make in
            make.center.equalToSuperview()
        }
        btn.setTitle("sign up", for: .normal)
        btn.addTarget(self, action: #selector(didtap), for: .touchUpInside)
    }
    @objc func didtap(_ sender: UIButton) {
        self.navigationController?.pushViewController(SetNameViewController(), animated: true)
    }
}
