//
//  CustomPopUp.swift
//  BookMark
//
//  Created by BoMin on 2023/01/14.
//

import UIKit
import SnapKit

class CustomPopUp: NSObject {
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.4
    }

//MARK: - Background and PopUp View
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    let popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    var myTargetView: UIView?
    
//MARK: - Labels
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.frame = CGRect(x: 0, y: 0, width: popUpView.frame.size.width, height: 80)
//        label.text = title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
//        label.frame = CGRect(x: 0, y: 30, width: popUpView.frame.size.width, height: 80)
        label.numberOfLines = 0
//        label.text = message
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .textBoldGray
        label.textAlignment = .center
        return label
    }()
    
    let slashLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "/"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .semiLightGray
        return label
    }()
    
//MARK: TextFields
    let currentPageTextField: UITextField = {
        let field = UITextField()
//        field.frame = CGRect(x: 0, y: 0, width: 120, height: 35)
        field.backgroundColor = .white
        field.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        field.layer.cornerRadius = 7
        field.layer.borderWidth = 1
        field.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        field.textAlignment = .center
        field.layer.borderColor = UIColor.semiLightGray.cgColor
        field.keyboardType = .numberPad
        return field
    }()
    
    let allPageTextField: UITextField = {
        let field = UITextField()
//        field.frame = CGRect(x: 0, y: 0, width: 120, height: 35)
        field.backgroundColor = .white
        field.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        field.layer.cornerRadius = 7
        field.layer.borderWidth = 1
        field.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        field.textAlignment = .center
        field.layer.borderColor = UIColor.semiLightGray.cgColor
        field.keyboardType = .numberPad
        field.isUserInteractionEnabled = false
        return field
    }()
    
//MARK: - Buttons
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 130, height: 40)
        btn.setTitle("입력", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = .lightOrange
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 20
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()
    
    let closeButton: UIButton = {
        let btn = UIButton()
        // 이미지 없어서 텍스트로 대체
        btn.setImage(UIImage(named: "cancel"), for: .normal)
        //btn.setTitle("닫기", for: .normal)
        //btn.setTitleColor(.textGray, for: .normal)
        return btn
    }()
    
    let rightImg: UIImageView = {
        let imgview = UIImageView()
        imgview.image = UIImage(named: "leftImg")
        return imgview
    }()
    
//MARK: - FUNC: ShowPopUP
    func showPopUp(with title: String,
                   message: String,
                   on viewController: UIViewController) {
        guard let targetView = viewController.view else {
            return
        }
        
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubviews(backgroundView, popUpView)
        
        popUpView.frame = CGRect(x: 40,
                                 y: -300,
                                 width: 343,
                                 height: 220)
        
        
//        popUpView.addSubviews(currentPageTextField, allPageTextField)
        
        titleLabel.text = title
        messageLabel.text = message
        
        closeButton.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
//        popUpView.addSubviews(titleLabel, messageLabel)
        
//        popUpView.addSubviews(submitButton, closeButton)
        
        setLayouts()
        
        
        UIView.animate(withDuration: 0.25,
                       animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
            print("dim view")
            
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.popUpView.center = targetView.center
                })
            }
        })
    }
    
////MARK: objc FUNC: SubmitPopUp
//    @objc func submitPopUp() {
//        // 페이지 입력 완료
//        print("submit button pressed")
//        guard let targetView = myTargetView else {
//            return
//        }
//
//        // 페이지 수 전달
//
//        UIView.animate(withDuration: 0.25,
//                       animations: {
//            self.popUpView.frame = CGRect(x: 40,
//                                          y: targetView.frame.size.height,
//                                          width: targetView.frame.size.width-80,
//                                          height: 200)
//        }, completion: { done in
//            if done {
//                UIView.animate(withDuration: 0.25, animations: {
//                    self.backgroundView.alpha = 0
//                    print("dim view disappear")
//                }, completion: { done in
//                    self.popUpView.removeFromSuperview()
//                    self.backgroundView.removeFromSuperview()
//                    print("popUpView removed from superview")
//                })
//            }
//        })
//    }
    
//MARK: objc FUNC: ClosePopUp
    @objc func closePopUp() {
        // 페이지 입력 완료
        print("close button pressed")
        guard let targetView = myTargetView else {
            return
        }
        
        UIView.animate(withDuration: 0.25,
                       animations: {
            self.popUpView.frame = CGRect(x: 40,
                                          y: targetView.frame.size.height,
                                          width: targetView.frame.size.width-80,
                                          height: 200)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                    print("dim view disappear")
                }, completion: { done in
                    self.popUpView.removeFromSuperview()
                    self.backgroundView.removeFromSuperview()
                    print("popUpView removed from superview")
                })
            }
        })
    }
    
}

extension CustomPopUp {
    func setLayouts() {
        
        popUpView.addSubviews(titleLabel, messageLabel, slashLabel, rightImg)
        
        titleLabel.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.height.equalTo(25)
//            make.bottom.equalToSuperview().offset(163)
        }
        
        messageLabel.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(65)
            make.height.equalTo(20)
//            make.bottom.equalToSuperview().offset(135)
        }
        
        slashLabel.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(111)
            make.height.equalTo(27)
        }
        
        popUpView.addSubviews(currentPageTextField, allPageTextField)
        
        currentPageTextField.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(35)
            make.top.equalToSuperview().offset(107)
            make.width.equalTo(120)
            make.height.equalTo(35)
        }
        
        allPageTextField.snp.makeConstraints() { make in
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalToSuperview().offset(107)
            make.width.equalTo(120)
            make.height.equalTo(35)
        }
        
        popUpView.addSubviews(submitButton, closeButton)
        
        submitButton.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(popUpView.snp.bottom).offset(-19)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        closeButton.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-13)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        rightImg.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(35)
            make.width.equalTo(27)
            make.height.equalTo(35)
        }
        
    }
}
