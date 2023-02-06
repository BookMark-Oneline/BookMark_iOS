//
//  CreateCommunityViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import UIKit

// MARK: - 모임 생성 view controller
class CreateCommunityViewController: UIViewController {
    let layout_SetCommunity = CommunitySettingView()
    let imgPicker = UIImagePickerController()
    let label_title = UILabel()
    let layout_main = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setBaseView()
        setNavCustom()
        setImgPicker()
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
        self.setNavigationCustom(title: "모임 생성")
        self.setNavigationLabelButton(title: "완료", action: #selector(goBackCommunityTab))
    }
    
    @objc func goBackCommunityTab(_ sender: UIBarButtonItem) {
        if let appdel = UIApplication.shared.delegate as? AppDelegate {
            appdel.communities.append(["myeongsoo", "책과 무스비"])
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}


// MARK: - 이미지 피커 컨트롤러 extension
extension CreateCommunityViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
