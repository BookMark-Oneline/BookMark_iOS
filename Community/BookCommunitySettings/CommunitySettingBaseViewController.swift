//
//  CommunitySettingBaseViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import UIKit

// MARK: - 모임 설정 기본 공통 view controller
class CommunitySettingBaseViewController: UIViewController {
    let layout_SetCommunity = CommunitySettingView()
    
    let invitationtapGestureRecognizer_all = UITapGestureRecognizer()
    let invitationtapGestureRecognizer_select = UITapGestureRecognizer()
    let invitationtapGestureRecognizer_reject = UITapGestureRecognizer()
    
    let limittapGestureRecognizer_10 = UITapGestureRecognizer()
    let limittapGestureRecognizer_20 = UITapGestureRecognizer()
    let limittapGestureRecognizer_nolimit = UITapGestureRecognizer()
    
    let imgPickerTapGestureRecognizer = UITapGestureRecognizer()
    
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setGestureRecognizer()
        setImgPicker()
    }
}

// MARK: - 버튼 반응 extension
extension CommunitySettingBaseViewController {
    
    private func setGestureRecognizer() {
        // MARK: 초대 설정
        invitationtapGestureRecognizer_all.addTarget(self, action: #selector(setInvitationAction_all))
        layout_SetCommunity.layout_all.addGestureRecognizer(invitationtapGestureRecognizer_all)
        
        invitationtapGestureRecognizer_select.addTarget(self, action: #selector(setInvitationAction_select))
        layout_SetCommunity.layout_select.addGestureRecognizer(invitationtapGestureRecognizer_select)
        
        invitationtapGestureRecognizer_reject.addTarget(self, action: #selector(setInvitationAction_reject))
        layout_SetCommunity.layout_reject.addGestureRecognizer(invitationtapGestureRecognizer_reject)
        
        // MARK: 인원 제한
        limittapGestureRecognizer_10.addTarget(self, action: #selector(setLimitAction_10))
        layout_SetCommunity.layout_10.addGestureRecognizer(limittapGestureRecognizer_10)
        
        limittapGestureRecognizer_20.addTarget(self, action: #selector(setLimitAction_20))
        layout_SetCommunity.layout_20.addGestureRecognizer(limittapGestureRecognizer_20)
        
        limittapGestureRecognizer_nolimit.addTarget(self, action: #selector(setLimitAction_noLimit))
        layout_SetCommunity.layout_noLimit.addGestureRecognizer(limittapGestureRecognizer_nolimit)
        
    }
    
    // MARK: 초대 설정 버튼 메소드
    @objc func setInvitationAction_all(_ sender: UITapGestureRecognizer) {
        setBtnAttribute_Selected(btn: layout_SetCommunity.layout_all, label: layout_SetCommunity.label_all)
        setBtnAttribute_UnSelected(btn: layout_SetCommunity.layout_select, layout_SetCommunity.layout_reject, label: layout_SetCommunity.label_select, layout_SetCommunity.label_reject)
    }
    
    @objc func setInvitationAction_select(_ sender: UITapGestureRecognizer) {
        setBtnAttribute_Selected(btn: layout_SetCommunity.layout_select, label: layout_SetCommunity.label_select)
        setBtnAttribute_UnSelected(btn: layout_SetCommunity.layout_all, layout_SetCommunity.layout_reject, label: layout_SetCommunity.label_all, layout_SetCommunity.label_reject)
    }
    
    @objc func setInvitationAction_reject(_ sender: UITapGestureRecognizer) {
        setBtnAttribute_Selected(btn: layout_SetCommunity.layout_reject, label: layout_SetCommunity.label_reject)
        setBtnAttribute_UnSelected(btn: layout_SetCommunity.layout_select, layout_SetCommunity.layout_all, label: layout_SetCommunity.label_select, layout_SetCommunity.label_all)
    }
    
    // MARK: 인원 제한 버튼 메소드
    @objc func setLimitAction_10(_ sender: UITapGestureRecognizer) {
        setBtnAttribute_Selected(btn: layout_SetCommunity.layout_10, label: layout_SetCommunity.label_10)
        setBtnAttribute_UnSelected(btn: layout_SetCommunity.layout_20, layout_SetCommunity.layout_noLimit, label: layout_SetCommunity.label_20, layout_SetCommunity.label_noLimit)
    }
    
    @objc func setLimitAction_20(_ sender: UITapGestureRecognizer) {
        setBtnAttribute_Selected(btn: layout_SetCommunity.layout_20, label: layout_SetCommunity.label_20)
        setBtnAttribute_UnSelected(btn: layout_SetCommunity.layout_10, layout_SetCommunity.layout_noLimit, label: layout_SetCommunity.label_10, layout_SetCommunity.label_noLimit)
    }
    
    @objc func setLimitAction_noLimit(_ sender: UITapGestureRecognizer) {
        setBtnAttribute_Selected(btn: layout_SetCommunity.layout_noLimit, label: layout_SetCommunity.label_noLimit)
        setBtnAttribute_UnSelected(btn: layout_SetCommunity.layout_10, layout_SetCommunity.layout_20, label: layout_SetCommunity.label_10, layout_SetCommunity.label_20)
    }
    
    // MARK: 버튼 액션에 따른 반응 메소드
    private func setBtnAttribute_Selected(btn: UIView, label: UILabel) {
        btn.backgroundColor = .lightOrange
        label.textColor = .white
    }
    
    private func setBtnAttribute_UnSelected(btn: UIView..., label: UILabel...) {
        for button in btn {
            button.backgroundColor = .white
        }
        
        for lbl in label {
            lbl.textColor = .textBoldGray
        }
    }
}


// MARK: - 이미지 피커 컨트롤러 extension
extension CommunitySettingBaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func setImgPicker() {
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        imgPicker.delegate = self
        
        imgPickerTapGestureRecognizer.addTarget(self, action: #selector(imagePicker))
        layout_SetCommunity.layout_img.addGestureRecognizer(imgPickerTapGestureRecognizer)
    }
    
    @objc func imagePicker(_ sender: UITapGestureRecognizer) {
        present(self.imgPicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        self.layout_SetCommunity.layout_img.image = newImage
        picker.dismiss(animated: true, completion: {
            self.layout_SetCommunity.img_iconIMG.isHighlighted = true
        })
    }
}
