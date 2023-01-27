//
//  CreatePostViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import UIKit

// MARK: - 게시글 작성 view controller
class CreatePostViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let layout_createPost = CreatePostView()
    let cameraTapGestureRecognizer = UITapGestureRecognizer()
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout_createPost.initViews(self.view)
        
        layout_createPost.txt_post.delegate = self
        
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        
        cameraTapGestureRecognizer.addTarget(self, action: #selector(presentImgPicker))
        layout_createPost.img_camera.addGestureRecognizer(cameraTapGestureRecognizer)
    }
    
    // MARK: 내용 text view 입력 이벤트
    func textViewDidBeginEditing(_ textView: UITextView) {
        removeAllText(textView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
      }
    
    private func removeAllText(_ textView: UITextView) {
        if textView.text ==  "내용을 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // MARK: 카메라 아이콘 터치 이벤트
    @objc func presentImgPicker(_ sender: UITapGestureRecognizer) {
        self.present(imgPicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        removeAllText(layout_createPost.txt_post)
        
        let attachment = NSTextAttachment()
        attachment.image = newImage
                
        let attachmentString = NSAttributedString(attachment: attachment)
        layout_createPost.txt_post.textStorage.insert(attachmentString, at: 0)
        imgPicker.dismiss(animated: true)
    }
}

// MARK: - 키보드 높이에 따른 view 이동 extension
extension CreatePostViewController {
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardUp(_ sender: NSNotification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
        
             UIView.animate(
                 withDuration: 0
                 , animations: {
                     self.layout_createPost.layout_bottom.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height + self.view.safeAreaInsets.bottom)
                     let height = (self.layout_createPost.layout_bottom.layer.position.y) - (self.layout_createPost.line1.layer.position.y + 24)
                     self.layout_createPost.txt_post.snp.remakeConstraints() { make in
                         make.top.equalTo(self.layout_createPost.line1.snp.bottom).offset(24)
                         make.leading.equalToSuperview().offset(23)
                         make.trailing.equalToSuperview().offset(-23)
                         make.height.equalTo(height - keyboardRectangle.height)
                     }
                 }
             )
         }
    }
    
    @objc func keyboardDown(_ sender: NSNotification) {
        self.layout_createPost.layout_bottom.transform = .identity
        self.layout_createPost.txt_post.snp.remakeConstraints() {make in
            make.top.equalTo(self.layout_createPost.line1.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            make.bottom.equalTo(self.layout_createPost.layout_bottom.snp.top)
        }
    }
}

// MARK: - 게시글 작성 view
class CreatePostView {
    let layout_main = UIView()
    
    let txt_title = UITextField()
    let line1 = UIView()
    let txt_post = UITextView()
    
    let layout_bottom = UIView()
    let line2 = UIView()
    let img_camera = UIImageView()
    
    func initViews(_ superView: UIView) {
        superView.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(superView.safeAreaLayoutGuide)
        }
        
        layout_main.addSubviews(txt_title, line1, txt_post, layout_bottom)
        txt_title.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(29)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }
        txt_title.placeholder = "제목을 입력하세요."
        txt_title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        line1.snp.makeConstraints() { make in
            make.top.equalTo(txt_title.snp.bottom).offset(9)
            make.width.equalTo(344)
            make.leading.equalToSuperview().offset(23)
            make.height.equalTo(1)
        }
        line1.backgroundColor = .semiLightGray
        
        layout_bottom.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalToSuperview()
        }
        layout_bottom.addSubviews(line2, img_camera)
        line2.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        line2.backgroundColor = .semiLightGray
        
        img_camera.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
            make.size.equalTo(28)
        }
        img_camera.image = UIImage(named: "iconCAMERA")
        img_camera.isUserInteractionEnabled = true
        
        txt_post.snp.makeConstraints() { make in
            make.top.equalTo(line1.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            make.bottom.equalTo(layout_bottom.snp.top)
        }
        txt_post.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        txt_post.text = "내용을 입력하세요."
        txt_post.textColor = .semiLightGray
    }
}
