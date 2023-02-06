//
//  LoginView.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/06.
//

import UIKit
import SnapKit
import Pastel

// MARK: - 로그인 뷰
class LoginView {
    let img_logo = UIImageView()
    let layout_main = UIImageView()
    let img_ribon = UIImageView()
    let img_mainlogo = UIImageView()
    let label_startService = UILabel()
    let btn_appleLogin = UIButton()
    let label_loginProblem = UILabel()
    
    func initViews(_ superView: UIView) {
        let pastelView = PastelView(frame: superView.bounds)

        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight

        pastelView.animationDuration = 3.0

        // 3개
       pastelView.setColors([UIColor(Hex: 0xe65c00), UIColor(Hex: 0xF9D423), UIColor(Hex: 0xFF4E50)])

        pastelView.startAnimation()
        superView.insertSubview(pastelView, at: 0)
        
        superView.addSubviews(img_logo, layout_main, img_ribon)
        img_logo.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(29)
            make.width.equalTo(81)
            make.height.equalTo(113)
        }
        img_logo.image = UIImage(named: "splashIcon")
        
        layout_main.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(257)
            make.centerX.equalToSuperview()
            make.height.equalTo(466)
            make.width.equalTo(270)
        }
        layout_main.isUserInteractionEnabled = true
        layout_main.image = UIImage(named: "back.png")
        layout_main.layer.cornerRadius = 25
        layout_main.layer.shadowColor = UIColor.black.cgColor
        layout_main.layer.masksToBounds = false
        layout_main.layer.shadowOffset = CGSize(width: 3, height: 5)
        layout_main.layer.shadowOpacity = 0.3
        
        img_ribon.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(layout_main.snp.top).offset(17)
            make.width.equalTo(30)
            make.height.equalTo(121)
        }
        img_ribon.image = UIImage(named: "ribon.png")
        
        layout_main.addSubviews(img_mainlogo, label_startService, btn_appleLogin, label_loginProblem)
        
        img_mainlogo.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(125)
            make.centerX.equalToSuperview()
            make.size.equalTo(92)
        }
        img_mainlogo.image = UIImage(named: "submain")
        
        label_startService.snp.makeConstraints() { make in
            make.top.equalTo(img_mainlogo.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        label_startService.sizeToFit()
        label_startService.text = "책갈피 시작하기"
        label_startService.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        btn_appleLogin.snp.makeConstraints() { make in
            make.top.equalTo(label_startService.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(209)
            make.height.equalTo(38)
        }
        btn_appleLogin.backgroundColor = .textLightGray
        btn_appleLogin.layer.cornerRadius = 20
        btn_appleLogin.setTitle("애플로 시작하기", for: .normal)
        
        label_loginProblem.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        label_loginProblem.sizeToFit()
        label_loginProblem.text = "로그인에 문제가 있나요?"
        label_loginProblem.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label_loginProblem.textColor = .textLightGray
        
    }
    
}
