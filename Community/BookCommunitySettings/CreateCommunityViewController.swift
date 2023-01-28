//
//  CreateCommunityViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import UIKit

// MARK: - 모임 생성 view controller
class CreateCommunityViewController: CommunitySettingBaseViewController {
    let label_title = UILabel()
    let layout_main = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseView()
        setNavCustom()
    }
    
    private func setBaseView() {
        view.addSubviews(label_title, layout_main)
        label_title.snp.makeConstraints() { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(23)
        }
        label_title.text = "모임을 생성하고\n책을 함께 나누어보세요"
        label_title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label_title.numberOfLines = 0
        label_title.sizeToFit()
        
        layout_main.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        layout_SetCommunity.initViews(layout_main)
    }
    
    private func setNavCustom() {
        self.navigationItem.title = "모임 생성"
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        let okBtn = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(goBackCommunityTab))
        okBtn.tintColor = .textOrange
        
        self.navigationItem.rightBarButtonItems = [okBtn]
    }
    
    @objc func goBackCommunityTab(_ sender: UIBarButtonItem) {
        print("ok")
    }
}
