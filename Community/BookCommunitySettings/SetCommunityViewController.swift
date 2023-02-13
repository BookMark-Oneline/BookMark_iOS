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
    let network = Network()
    let layout_main = UIView()
    let layout_SetCommunity = CommunitySettingView()
    let imgPicker = UIImagePickerController()
    var clubID: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        getSettings()
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

// MARK: - 네트워크 용 extension
extension SetCommunityViewController{
    func getSettings() {
        network.getCommunitySetting(clubID: self.clubID, completion: { res in
            switch res {
            case .success(let data):
                guard let setting = (data as? CommunitySetting)?.clubData[0] else {return}

                self.layout_SetCommunity.layout_img.setImageUrl(url: setting.club_img_url)
                self.layout_SetCommunity.txt_commName.text = setting.club_name
                self.layout_SetCommunity.btn_invitation.selectedSegmentIndex = setting.club_invite_option
                self.layout_SetCommunity.btn_limit.selectedSegmentIndex = setting.max_people_num
                
            default:
                print("failed")
            }
        })
    }
}
