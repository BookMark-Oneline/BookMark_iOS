//
//  MyPageTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit

// MARK: - 마이 페이지 탭
class MyPageTab: UIViewController {
    let layout_myPageView = MyPageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        layout_myPageView.initViews(self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

}

// MARK: - 마이 페이지 뷰
class MyPageView {
    let layout_main = UIView()
    
    let label_title = UILabel()
    let line1 = UIView()
    
    var layout_profile = UIView()
    var layout_circle = UIView()
    var img_profile = UIImageView()
    
    var label_name = UILabel()
    var label_message = UILabel()
    
    let btn_settingProfile = UIButton()
    
    let line2 = UIView()
    
    let layout_table = UIView()
    let cell_alarm = ProfileSettingCell()
    let cell_share = ProfileSettingCell()
    let cell_subscription = ProfileSettingCell()
    let cell_isPrivate = ProfileSettingCell()
    let cell_privacy = ProfileSettingCell()
    let cell_logout = ProfileSettingCell()
    let cell_withdraw = ProfileSettingCell()
    
    let line3 = UIView()

    func initViews(_ superView: UIView) {
        superView.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(superView.safeAreaLayoutGuide)
        }
        
        layout_main.addSubviews(label_title, line1, layout_table)
        label_title.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(23)
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }
        label_title.text = "마이페이지"
        label_title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        line1.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        line1.backgroundColor = .lightGray
        
        layout_main.addSubviews(layout_profile)
        layout_profile.snp.makeConstraints() { make in
            make.top.equalTo(line1.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        layout_profile.addSubviews(layout_circle, label_name, label_message, btn_settingProfile, line2)
        layout_circle.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(23)
            make.size.equalTo(85)
        }
        layout_circle.layer.cornerRadius = 81 / 2.0
        layout_circle.translatesAutoresizingMaskIntoConstraints = false
        layout_circle.layer.borderWidth = 1.1
        layout_circle.layer.borderColor = UIColor.lightGray.cgColor
        
        layout_circle.addSubview(img_profile)
        img_profile.snp.makeConstraints() { make in
            make.size.equalTo(75)
            make.center.equalToSuperview()
        }
        img_profile.layer.cornerRadius = 75 / 2.0
        img_profile.image = UIImage(named: "pepe.jpg")
        img_profile.clipsToBounds = true
        img_profile.translatesAutoresizingMaskIntoConstraints = false
        
        label_name.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(43)
            make.leading.equalTo(layout_circle.snp.trailing).offset(14)
        }
        label_name.text = "독서왕페페"
        label_name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label_name.sizeToFit()
        
        label_message.snp.makeConstraints() { make in
            make.top.equalTo(label_name.snp.bottom).offset(7)
            make.leading.equalTo(label_name)
            make.trailing.equalToSuperview().offset(-23)
        }
        label_message.text = "올해의 목표는 100권"
        label_message.textAlignment = .left
        label_message.lineBreakMode = .byTruncatingTail
        label_message.textColor = .textLightGray
        label_message.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        btn_settingProfile.snp.makeConstraints() { make in
            make.top.equalTo(img_profile.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            make.height.equalTo(35)
        }
        btn_settingProfile.setTitle("프로필 설정", for: .normal)
        btn_settingProfile.setTitleColor(.textBoldGray, for: .normal)
        btn_settingProfile.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        btn_settingProfile.layer.borderWidth = 1
        btn_settingProfile.layer.borderColor = UIColor.semiLightGray.cgColor
        btn_settingProfile.layer.cornerRadius = 6
        
        line2.snp.makeConstraints() { make in
            make.top.equalTo(btn_settingProfile.snp.bottom).offset(25)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        line2.backgroundColor = .lightGray
        
        layout_main.addSubview(layout_table)
        layout_table.snp.makeConstraints() { make in
            make.top.equalTo(layout_profile.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        layout_table.addSubviews(cell_alarm, cell_share, cell_subscription, cell_isPrivate, line3, cell_privacy, cell_logout, cell_withdraw)
        cell_alarm.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        cell_alarm.initViews(isBtn: true, isSwitch: false, txt: "알림 설정", txtColor: .black)
        
        cell_share.snp.makeConstraints() { make in
            make.top.equalTo(cell_alarm.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        cell_share.initViews(isBtn: true, isSwitch: false, txt: "정보 공유 설정", txtColor: .black)
        
        cell_subscription.snp.makeConstraints() { make in
            make.top.equalTo(cell_share.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        cell_subscription.initViews(isBtn: true, isSwitch: false, txt: "구독 내역", txtColor: .black)
        
        cell_isPrivate.snp.makeConstraints() { make in
            make.top.equalTo(cell_subscription.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        cell_isPrivate.initViews(isBtn: false, isSwitch: true, txt: "계정 비공개", txtColor: .black)
        
        line3.snp.makeConstraints() { make in
            make.top.equalTo(cell_isPrivate.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        line3.backgroundColor = .lightGray
        
        cell_privacy.snp.makeConstraints() { make in
            make.top.equalTo(line3.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        cell_privacy.initViews(isBtn: false, isSwitch: false, txt: "개인정보 보호", txtColor: .black)
        
        cell_logout.snp.makeConstraints() { make in
            make.top.equalTo(cell_privacy.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        cell_logout.initViews(isBtn: false, isSwitch: false, txt: "로그아웃", txtColor: .black)
        
        cell_withdraw.snp.makeConstraints() { make in
            make.top.equalTo(cell_logout.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        cell_withdraw.initViews(isBtn: false, isSwitch: false, txt: "회원 탈퇴", txtColor: .red)
        
    }
}

// MARK: Cell 커스텀
class ProfileSettingCell: UIView {
    let title = UILabel()
    let btn = UIImageView()
    let switchs = UISwitch()
    
    func initViews(isBtn: Bool, isSwitch: Bool, txt: String, txtColor: UIColor) {
        if (isBtn && !isSwitch) {
            self.addSubview(btn)
          
            btn.snp.makeConstraints() { make in
                make.centerY.equalToSuperview()
                make.width.equalTo(6)
                make.height.equalTo(12)
                make.right.equalToSuperview().offset(-24)
            }
            btn.image = UIImage(named: "right")
        }
        
        else if (!isBtn && isSwitch) {
            self.addSubview(switchs)
            switchs.snp.makeConstraints() { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-25)
            }
            switchs.onTintColor = .lightOrange
        }
        self.addSubview(title)
        title.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
        }
        title.text = txt
        title.textColor = txtColor
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}
