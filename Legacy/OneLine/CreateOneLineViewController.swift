//
//  CreateOneLineViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/09.
//

import UIKit
import SnapKit

// MARK: - 오늘 한 줄 생성 view controller
class CreateOneLineViewController: UIViewController {
    let createOneLineview = CreateOneLineView()
    let imgPicker = UIImagePickerController()
    
    var userImageData: UIImage? = UIImage(named: "backImg")
    var userTextData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setNavCustom()
        setImgPicker()
        createOneLineview.txt_mainV.delegate = self
        
        createOneLineview.initViews(self.view)
        createOneLineview.btn_setImg.addTarget(self, action: #selector(didTapSetImgButton), for: .touchUpInside)
    }
    
    private func setNavCustom() {
        self.setNavigationCustom(title: "한 줄 작성")
        self.setNavigationLabelButton(title: "게시", action: #selector(didTapPostButton))
    }
    
    @objc func didTapPostButton(_ sender: UIBarButtonItem) {
        self.createOneLineview.img_backgound.removeFromSuperview()
        self.userTextData = self.createOneLineview.txt_mainV.text
        if let rootVC = navigationController?.viewControllers.first as? OneLineTab {
            rootVC.txtUserData = self.userTextData
            rootVC.imgUserData = self.userImageData
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didTapSetImgButton(_ sender: UIButton) {
        self.present(imgPicker, animated: true)
    }
}

// MARK: - Image Picker extension
extension CreateOneLineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func setImgPicker() {
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        imgPicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        self.createOneLineview.img_backgound.image = newImage
        self.userImageData = newImage
        imgPicker.dismiss(animated: true)
    }
}


// MARK: - TextView delegate extension
extension CreateOneLineViewController: UITextViewDelegate {
    // MARK: 내용 text view 입력 이벤트
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.createOneLineview.label_placeholder.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
      }
}

// MARK: - 키보드 높이에 따른 view 이동 extension
extension CreateOneLineViewController {
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.createOneLineview.img_backgound.removeFromSuperview()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardUp(_ sender: NSNotification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
        
            self.view.addSubview(self.createOneLineview.layout_settings)
            self.createOneLineview.layout_settings.snp.makeConstraints() { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().inset(keyboardRectangle.height)
                make.height.equalTo(48)
                
            }
            self.createOneLineview.didStartEditing(self.view)
            
            UIView.animate(
                withDuration: 0
                , animations: {
                    let height = self.createOneLineview.layout_main.frame.height
                    self.createOneLineview.txt_mainV.snp.remakeConstraints() { make in
                        make.top.leading.trailing.equalToSuperview()
                        make.height.equalTo(height - keyboardRectangle.height - 10)
                    }
                }
            )
         }
    }
    
    @objc func keyboardDown(_ sender: NSNotification) {
        self.createOneLineview.btn_color.removeFromSuperview()
        self.createOneLineview.layout_vertical.removeFromSuperview()
        self.createOneLineview.btn_font.removeFromSuperview()
        self.createOneLineview.btn_size.removeFromSuperview()
        self.createOneLineview.layout_settings.removeFromSuperview()
        
        self.createOneLineview.txt_mainV.snp.remakeConstraints() {make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(390)
            make.top.equalToSuperview().offset(118)
        }
    }
}

// MARK: - 오늘 한 줄 생성 view
class CreateOneLineView {
    let layout_main = UIView()
    let img_backgound = UIImageView()
    let label_placeholder = UILabel()
    let txt_mainV = UITextView()
    let btn_setImg = UIButton()
    let label_setImg = UILabel()
    let layout_settings = UIView()
    let btn_font = UIButton()
    let btn_size = UIButton()
    let layout_vertical = UIView()
    let btn_color = UIButton()
    
    func initViews(_ superView: UIView) {
        superView.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(superView.safeAreaLayoutGuide)
        }
        layout_main.addSubviews(img_backgound, txt_mainV, label_placeholder, btn_setImg, label_setImg)
        
        img_backgound.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
        img_backgound.backgroundColor = .clear
        img_backgound.contentMode = .scaleAspectFill
        img_backgound.layer.opacity = 0.8
        
        txt_mainV.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(390)
            make.top.equalToSuperview().offset(118)
        }
        txt_mainV.textContainerInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
        txt_mainV.backgroundColor = UIColor(Hex: 0xE3E3E3)
        txt_mainV.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        txt_mainV.textColor = .textGray
        txt_mainV.layer.opacity = 0.8
        txt_mainV.textAlignment = .center
        
        label_placeholder.snp.makeConstraints() { make in
            make.center.equalTo(txt_mainV)
        }
        label_placeholder.setTxtAttribute("텍스트를 입력하세요", size: 18, weight: .medium, txtColor: .textBoldGray)
        
        btn_setImg.snp.makeConstraints() { make in
            make.top.equalTo(txt_mainV.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(23)
            make.size.equalTo(33)
        }
        btn_setImg.tintColor = .textBoldGray
        btn_setImg.setImage(UIImage(systemName: "photo"), for: .normal)
        
        label_setImg.snp.makeConstraints() { make in
            make.top.equalTo(btn_setImg.snp.bottom).offset(3)
            make.centerX.equalTo(btn_setImg)
        }
        label_setImg.setTxtAttribute("배경 설정", size: 12, weight: .medium, txtColor: .textBoldGray)
    }
    
    func didStartEditing(_ superView: UIView) {
        layout_settings.backgroundColor = .white
        layout_settings.addSubviews(btn_font, btn_size, layout_vertical, btn_color)
        btn_font.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
        }
        btn_font.sizeToFit()
        btn_font.setTitle("T", size: 15, weight: .bold, color: .textBoldGray)
        
        btn_size.snp.makeConstraints() { make in
            make.leading.equalTo(btn_font.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        btn_size.sizeToFit()
        btn_size.setTitle("13pt", size: 13, weight: .semibold, color: .black)
        
        layout_vertical.snp.makeConstraints() { make in
            make.height.equalTo(14)
            make.width.equalTo(3)
            make.leading.equalTo(btn_size.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        layout_vertical.backgroundColor = .lightGray
        
        btn_color.snp.makeConstraints() { make in
            make.leading.equalTo(layout_vertical.snp.trailing).offset(10)
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
        }
        btn_color.layer.cornerRadius = 10
        btn_color.backgroundColor = .textBoldGray
    }
}
