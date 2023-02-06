//
//  SetCommunityViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import UIKit
import SnapKit

// MARK: - 모임 설정 view controller
class SetCommunityViewController: UIViewController {
    let layout_main = UIView()
    let layout_SetCommunity = CommunitySettingView()
    let imgPicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        layout_SetCommunity.initViews(self.view)
        setImgPicker()
        setNavCustom()
    }
    
    private func setNavCustom() {
        self.setNavigationCustom(title: "모임 설정")
        self.setNavigationLabelButton(title: "수정", action: #selector(popToCommunityInsideViewController))
    }
    
    @objc func popToCommunityInsideViewController(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - 이미지 피커 컨트롤러 extension
extension SetCommunityViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
