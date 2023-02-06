//
//  CommunitySettingBaseViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import UIKit

// MARK: - Legacy

// MARK: - 모임 설정 기본 공통 view controller
class CommunitySettingBaseViewController: UIViewController {
    let layout_SetCommunity = CommunitySettingView()
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setImgPicker()
    }
}

// MARK: - 이미지 피커 컨트롤러 extension
extension CommunitySettingBaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func setImgPicker() {
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        imgPicker.delegate = self
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
