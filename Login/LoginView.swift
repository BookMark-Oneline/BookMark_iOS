//
//  LoginView.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/06.
//

import UIKit
import SnapKit
import Pastel
import AuthenticationServices

// MARK: - 로그인 뷰
class LoginView {
    let img_mainlogo = UIImageView()
    let btn_appleLogin = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    let label_loginProblem = UILabel()
    
    func initViews(_ superView: UIView) {
        let pastelView = PastelView(frame: superView.bounds)

        pastelView.startPastelPoint = .top
        pastelView.endPastelPoint = .bottom

        pastelView.animationDuration = 3.0

        // 3개
       //pastelView.setColors([UIColor(Hex: 0xe65c00), UIColor(Hex: 0xF9D423), UIColor(Hex: 0xFF4E50)])
       pastelView.setColors([UIColor(Hex: 0xFFCA0C), UIColor(Hex: 0xF99030), UIColor(Hex: 0xFFCA0C), UIColor(Hex: 0xF99030), UIColor(Hex: 0xFFCA0C), UIColor(Hex: 0xF99030)])

        pastelView.startAnimation()
        superView.insertSubview(pastelView, at: 0)
        
        superView.addSubviews(img_mainlogo, btn_appleLogin, label_loginProblem)
        
        img_mainlogo.snp.makeConstraints() { make in
            make.center.equalToSuperview()
            make.width.equalTo(154)
            make.height.equalTo(211)
        }
        img_mainlogo.image = UIImage(named: "loginLogo")
        
        btn_appleLogin.snp.makeConstraints() { make in
            make.bottom.equalToSuperview().offset(-127)
            make.width.equalTo(332)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
        btn_appleLogin.cornerRadius = 20
        
        label_loginProblem.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn_appleLogin.snp.bottom).offset(20)
        }
        label_loginProblem.sizeToFit()
        label_loginProblem.text = "로그인에 문제가 있나요?"
        label_loginProblem.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label_loginProblem.textColor = .white
        
    }
    
}
