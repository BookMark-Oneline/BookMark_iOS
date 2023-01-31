//
//  SetCommunityViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import UIKit
import SnapKit

// MARK: - 모임 설정 view controller
class SetCommunityViewController: CommunitySettingBaseViewController {
    let layout_main = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseView()
        setNavCustom()
    }
    
    private func setNavCustom() {
        self.setNavigationCustom(title: "모임 설정")
        self.setNavigationLabelButton(title: "수정", action: #selector(popToCommunityInsideViewController))
    }
    
    @objc func popToCommunityInsideViewController(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setBaseView() {
        view.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        layout_SetCommunity.initViews(layout_main)
    }
}
