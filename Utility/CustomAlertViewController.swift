//
//  CustomAlertViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/06.
//

import UIKit
import SnapKit

// MARK: - Custom Alert 뷰 컨트롤러
class CustomAlertViewController: UIViewController {
    let alertView = CustomAlertView()
    var cancelCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.initViews(self.view)
        alertView.btn_ok.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        alertView.btn_cancel.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - setting
    func setAlertLabel(title: String, subtitle: String, titleColor: UIColor = .black, subtitleColor: UIColor = .textBoldGray) {
        alertView.label_title.text = title
        alertView.label_title.textColor = titleColor
        
        alertView.label_subtitle.text = subtitle
        alertView.label_subtitle.textColor = subtitleColor
    }
    
    // MARK: - Actions
    @objc private func didTapOkButton() {
        self.closeModal(self.cancelCompletion)
    }
    
    @objc private func didTapCancelButton() {
        self.closeModal()
    }
    
    private func closeModal(_ completed: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .clear
        } completion: { _ in
            self.dismiss(animated: true)
            completed?()
        }
    }
}

// MARK: - Custom Alert 뷰
class CustomAlertView {
    let layout_main = UIView()
    let img_bookmark = UIImageView(image: UIImage(named: "leftImg"))
    let label_title = UILabel()
    let label_subtitle = UILabel()
    let btn_ok = UIButton()
    let btn_cancel = UIButton()
    
    func initViews(_ superView: UIView) {
        superView.addSubview(layout_main)

        layout_main.snp.makeConstraints() { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(23)
            make.height.equalTo(173)
        }
        layout_main.backgroundColor = .white
        layout_main.layer.shadowColor = UIColor.black.cgColor
        layout_main.layer.shadowOffset = CGSize(width: 5, height: 5)
        layout_main.layer.shadowOpacity = 0.3
        layout_main.layer.shadowRadius = 20
        layout_main.layer.cornerRadius = 20
        
        layout_main.addSubviews(img_bookmark, label_title, label_subtitle, btn_ok, btn_cancel)
        
        img_bookmark.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(35)
            make.width.equalTo(27)
            make.height.equalTo(35)
        }
        
        label_title.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        label_title.text = "기록 삭제"
        label_title.textColor = .black
        label_title.font = UIFont.systemFont(ofSize: 20, weight: .black)
        
        label_subtitle.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
        }
        label_subtitle.text = "삭제한 기록은 복구가 불가합니다."
        label_subtitle.textColor = .textBoldGray
        label_subtitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        btn_ok.snp.makeConstraints() { make in
            make.top.equalTo(label_subtitle.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(33)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        btn_ok.backgroundColor = .lightOrange
        btn_ok.layer.cornerRadius = 20
        btn_ok.setTitle("삭제", size: 16, weight: .bold, color: .white)
        
        btn_cancel.snp.makeConstraints() { make in
            make.top.equalTo(btn_ok)
            make.trailing.equalToSuperview().offset(-33)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        btn_cancel.backgroundColor = .systemGray4
        btn_cancel.layer.cornerRadius = 20
        btn_cancel.setTitle("취소", size: 16, weight: .bold, color: .white)
    }
}
