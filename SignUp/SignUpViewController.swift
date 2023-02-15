//
//  SignUpViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/15.
//

import UIKit
import Alamofire

// MARK: - 회원 가입 베이스 뷰 컨트롤러
class BaseSignUpViewController: UIViewController {
    let layout_main = UIView()
    let label_title = UILabel()
    let progress = UIProgressView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setNavigationCustom(title: "")
        setBaseView()
    }
    
    private func setBaseView() {
        self.view.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        layout_main.addSubviews(progress, label_title, button)
        progress.snp.makeConstraints() { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(10)
        }
        progress.progressTintColor = .lightOrange
        progress.trackTintColor = .lightGray
        
        label_title.snp.makeConstraints() { make in
            make.top.equalTo(progress.snp.bottom).offset(53)
            make.leading.equalTo(30)
        }
        
        button.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-58)
        }
        button.backgroundColor = .lightOrange
        button.layer.cornerRadius = 26
        button.setTitle("다음", size: 17, weight: .bold, color: .white)
    }
    
    func setTextAttribute(_ text: String, boldStr: String) {
        label_title.numberOfLines = 0
        let str = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        str.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.count))
        str.addAttribute(.foregroundColor, value: UIColor.textOrange, range: (text as NSString).range(of: boldStr))
        
        label_title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label_title.attributedText = str
    }
}

// MARK: - 회원 가입 이름 설정 뷰 컨트롤러
class SetNameViewController: BaseSignUpViewController {
    let tf_name = UITextField()
    let line = UIView()
    let name_count = UILabel()
    let nameCountData = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        setTextAttribute("사용할 닉네임을\n설정해 주세요", boldStr: "닉네임")
        
        self.layout_main.addSubviews(tf_name, line, name_count, nameCountData)
        tf_name.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom).offset(44)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        tf_name.placeholder = "닉네임 입력"
        tf_name.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        tf_name.addTarget(self, action: #selector(didTextChanged), for: .editingChanged)
        
        line.snp.makeConstraints() { make in
            make.top.equalTo(tf_name.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(1)
        }
        line.backgroundColor = .semiLightGray
        
        nameCountData.snp.makeConstraints() { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
        }
        nameCountData.text = "0"
        nameCountData.textColor = UIColor(Hex: 0xBDBDBD)
        nameCountData.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        name_count.snp.makeConstraints() { make in
            make.centerY.equalTo(nameCountData)
            make.leading.equalTo(nameCountData.snp.trailing).offset(1)
        }
        name_count.text = "/10"
        name_count.textColor = UIColor(Hex: 0xBDBDBD)
        name_count.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTextChanged(_ sender: UITextField) {
        self.nameCountData.text = String(describing: sender.text?.count ?? 0)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        if let name = tf_name.text {
            if (!name.isEmpty) {
                UserInfo.shared.userName = name
            }
        }
        self.navigationController?.pushViewController(SetProfileViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress.setProgress(0.25, animated: animated)
    }
}

// MARK: - 회원 가입 프로필 설정 뷰 컨트롤러
class SetProfileViewController: BaseSignUpViewController {
    let layout_circle = UIView()
    let img_profile = UIImageView()
    let label_name = UILabel()
    let tf_message = UITextField()
    let line = UIView()
    let message_count = UILabel()
    let messageCountData = UILabel()
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImgPicker()
        setTextAttribute("자신의 프로필을\n설정해주세요", boldStr: "프로필")
        
        self.layout_main.addSubviews(tf_message, line, message_count, messageCountData, layout_circle, img_profile, label_name)
    
        self.progress.progress = 0.25
        layout_circle.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom).offset(76)
            make.centerX.equalToSuperview()
            make.size.equalTo(116)
        }
        layout_circle.layer.cornerRadius = 58
        layout_circle.translatesAutoresizingMaskIntoConstraints = false
        layout_circle.layer.borderWidth = 1
        layout_circle.layer.borderColor = UIColor.lightGray.cgColor
        layout_circle.backgroundColor = .lightGray
        layout_circle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
        
        layout_circle.addSubview(img_profile)
        img_profile.snp.makeConstraints() { make in
            make.size.equalTo(106)
            make.center.equalToSuperview()
        }
        img_profile.layer.cornerRadius = 53
        img_profile.image = UIImage(named: "noProfileImg")
        img_profile.clipsToBounds = true
        img_profile.translatesAutoresizingMaskIntoConstraints = false

        label_name.snp.makeConstraints() { make in
            make.top.equalTo(layout_circle.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        label_name.text = UserInfo.shared.userName
        label_name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        tf_message.snp.makeConstraints() { make in
            make.top.equalTo(label_name.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        tf_message.placeholder = "소개말 입력"
        tf_message.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        tf_message.addTarget(self, action: #selector(didTextChanged), for: .editingChanged)
        
        line.snp.makeConstraints() { make in
            make.top.equalTo(tf_message.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(1)
        }
        line.backgroundColor = .semiLightGray
        
        messageCountData.snp.makeConstraints() { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
        }
        messageCountData.text = "0"
        messageCountData.textColor = UIColor(Hex: 0xBDBDBD)
        messageCountData.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        message_count.snp.makeConstraints() { make in
            make.centerY.equalTo(messageCountData)
            make.leading.equalTo(messageCountData.snp.trailing).offset(1)
        }
        message_count.text = "/60"
        message_count.textColor = UIColor(Hex: 0xBDBDBD)
        message_count.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTextChanged(_ sender: UITextField) {
        self.messageCountData.text = String(describing: sender.text?.count ?? 0)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        if let msg = tf_message.text {
            if (!msg.isEmpty) {
                UserInfo.shared.userMessage = msg
            }
        }

        self.navigationController?.pushViewController(SetGoalViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress.setProgress(0.5, animated: animated)
    }
}

// MARK: 이미지 피커 컨트롤러 extension
extension SetProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        self.img_profile.image = newImage
        UserInfo.shared.userImg = newImage
        
        picker.dismiss(animated: true, completion: {
          print("dismissed")
        })
    }
}

// MARK: - 회원 가입 목표 독서 시간 설정 뷰 컨트롤러
class SetGoalViewController: BaseSignUpViewController {
    let img_hourglass = UIImageView()
    let label_top = UILabel()
    let label_bottom = UILabel()
    let label_time = UILabel()
    let slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextAttribute("목표 독서 시간을\n설정하고 실천해보세요", boldStr: "목표 독서 시간")
        
        progress.progress = 0.5
        self.layout_main.addSubviews(img_hourglass, label_top, label_bottom, label_time, slider)
        img_hourglass.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom).offset(83)
            make.centerX.equalToSuperview()
            make.size.equalTo(144)
        }
        img_hourglass.image = UIImage(named: "hourglassImg")
        
        label_top.snp.makeConstraints() { make in
            make.top.equalTo(img_hourglass.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        label_top.text = "2022년 성인 기준"
        label_top.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        label_bottom.snp.makeConstraints() { make in
            make.top.equalTo(label_top.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        setBoldAttribute("평균보다 60분 많아요")
        
        slider.snp.makeConstraints() { make in
            make.bottom.equalTo(button.snp.top).offset(-44)
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(7)
        }
        slider.backgroundColor = .lightGray
        slider.thumbTintColor = .lightOrange
        slider.tintColor = .lightOrange
        slider.minimumValue = 10
        slider.maximumValue = 360
        slider.value = 90
        slider.addTarget(self, action: #selector(didSliderValueChanged), for: .valueChanged)
        
        label_time.snp.makeConstraints() { make in
            make.bottom.equalTo(slider.snp.top).offset(-58)
            make.centerX.equalToSuperview()
        }
        label_time.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label_time.text = "1시간 30분"

        button.setTitle("가입 완료", size: 17, weight: .bold, color: .white)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didSliderValueChanged(_ sender: UISlider) {
        let time = Int(sender.value)
        let hour = time / 60
        let min = Int(time % 60)
        label_time.text = "\(hour)시간 \(min)분"
        let timeDiff = time - 30
        if (timeDiff < 0) {
            setBoldAttribute("평균보다 \(30 - timeDiff)분 적어요")
        }
        else if (timeDiff > 0) {
            setBoldAttribute("평균보다 \(timeDiff)분 많아요")
        }
        else {
            setBoldAttribute(" 평균이에요")
        }
    }
    
    func setBoldAttribute(_ text: String) {
        let first = text.firstIndex(of: " ") ?? text.startIndex
        let last = text.lastIndex(of: " ") ?? text.startIndex
        
        let boldStr = text[first...last]
        let str = NSMutableAttributedString(string: text)
        str.addAttributes([.font: UIFont.systemFont(ofSize: 18, weight: .bold)], range: NSRange(location: 0, length: text.count))
        str.addAttribute(.foregroundColor, value: UIColor.textOrange, range: (text as NSString).range(of: String(boldStr)))
        self.label_bottom.attributedText = str
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        UserInfo.shared.userGoal = Int(self.slider.value)
        self.navigationController?.pushViewController(FinishSignUpViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress.setProgress(0.75, animated: animated)
    }
}

// MARK: - 설정 끝 뷰 컨트롤러
class FinishSignUpViewController: BaseSignUpViewController {
    let logo = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.progress = 0.75
        
        self.layout_main.addSubview(logo)
        logo.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.layout_main.snp.centerY).offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(98)
        }
        logo.image = UIImage(named: "splashIcon")
        
        label_title.snp.remakeConstraints() { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logo.snp.bottom).offset(30)
        }
        label_title.numberOfLines = 0
        label_title.text = "축하합니다!\n책갈피 회원이 되었어요🎉"
        label_title.textAlignment = .center
        label_title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        button.setTitle("시작하기", size: 17, weight: .bold, color: .white)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    @objc func didTapStartButton(_ sender: UIButton) {
        self.postNewCommunity(completion: { [weak self] in
            self?.present(LoginViewController(), animated: true)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress.setProgress(1, animated: animated)
    }
}

// MARK: 네트워크 용 extension
extension FinishSignUpViewController {
    func postNewCommunity(completion: @escaping () -> Void) {
        let baseUrl = "https://port-0-bookmark-oneliner-luj2cldx5nm16.sel3.cloudtype.app"
        let URL = baseUrl + "/login/register"
        guard let token = UserInfo.shared.userAccessToken else {
            print("no access token")
            return
        }
        
        let params: Parameters = ["user_name": UserInfo.shared.userNickName, "introduce_message": UserInfo.shared.userMessage, "goal": UserInfo.shared.userGoal, "access_token": token]
        
        if let img = UserInfo.shared.userImg {
            guard let imgData = img.jpegData(compressionQuality: 0.7) else {
                print("jpeg data failed")
                postWithNoUserImg(params, URL: URL, completion: {
                    completion()
                })
                return
            }
            postWithUserImg(params, URL: URL, userImgData: imgData, completion: {
                completion()
            })
        }
        else {
            postWithNoUserImg(params, URL: URL, completion: {
                completion()
            })
        }
    }
    
    private func postWithUserImg(_ params: Parameters, URL: String, userImgData: Data, completion: @escaping () -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(userImgData, withName: "img_url", fileName: "\(UserInfo.shared.userName)_profileImage.png" , mimeType: "image/png")
            
            for (key, value) in params
            {
                multipartFormData.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
            }
            
        }, to: URL, method: .post).responseData(completionHandler: { (response) in
            if let err = response.error {
                print("create community failed: \(err)")
                return
            }
            print(response.result)
            completion()
        })
    }
    
    private func postWithNoUserImg(_ params: Parameters, URL: String, completion: @escaping () -> Void) {
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { response in
            switch response.result {
            case .success:
                print("ok")

                completion()
            case .failure(let e):
                print("failed")
                print(e)
            }
        })
    }
}
