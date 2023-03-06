//
//  CommunityView.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/26.
//

import Foundation
import SnapKit

// MARK: - 책 모임 설정 뷰
class CommunitySettingView {
    let layout_main = UIView()
    let layout_scroll = UIScrollView()
    
    let label_bookCommID = UILabel()
    let label_code = UILabel()
    let line1 = UIView()
    let label_codeDescription = UILabel()
    
    let label_setComm = UILabel()

    let layout_img = UIImageView()
    let img_iconIMG = UIImageView()
    
    let txt_commName = UITextField()
    
    let line2 = UIView()
    
    let label_setInvitation = UILabel()
    let btn_invitation = UISegmentedControl(items: ["모든 가입 허용", "일부 가입 허용", "모든 가입 거부"])
    let label_setInvitationDescription = UILabel()
    
    let label_limit = UILabel()
    let btn_limit = UISegmentedControl(items: ["10", "20", "무제한"])
    let label_limitDescription = UILabel()
    
    func initViews(_ superView: UIView, clubID: Int) {
        superView.addSubview(layout_scroll)
        
        layout_scroll.translatesAutoresizingMaskIntoConstraints = false
        layout_scroll.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
        layout_scroll.contentLayoutGuide.snp.makeConstraints() { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(850)
        }
        
        layout_scroll.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(layout_scroll.contentLayoutGuide)
        }
        
        layout_main.addSubviews(label_bookCommID, label_code, line1, label_codeDescription, label_setComm, txt_commName, layout_img, line2, label_setInvitation, btn_invitation, label_setInvitationDescription, label_limit, btn_limit, label_limitDescription)
        
        label_bookCommID.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(23)
        }
        label_bookCommID.text = "책모임 ID"
        label_bookCommID.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label_bookCommID.sizeToFit()
        
        label_code.snp.makeConstraints() { make in
            make.top.equalTo(label_bookCommID.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(26)
        }
        label_code.text = "\(clubID)"
        label_code.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label_code.textColor = .textOrange
        
        line1.snp.makeConstraints() { make in
            make.top.equalTo(label_code.snp.bottom).offset(11)
            make.width.equalTo(338)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        line1.backgroundColor = .semiLightGray
        
        label_codeDescription.snp.makeConstraints() { make in
            make.top.equalTo(line1.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(26)
        }
        label_codeDescription.text = "일련번호는 자동으로 주어지며 모임 검색 시 사용가능 합니다."
        label_codeDescription.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label_codeDescription.textColor = .textLightGray
        label_codeDescription.sizeToFit()
        
        label_setComm.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.top.equalTo(label_codeDescription.snp.bottom).offset(60)
        }
        label_setComm.text = "모임 설정"
        label_setComm.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        layout_img.snp.makeConstraints() { make in
            make.top.equalTo(label_setComm.snp.bottom).offset(19)
            make.width.equalTo(338)
            make.height.equalTo(108)
            make.centerX.equalToSuperview()
        }
        layout_img.layer.cornerRadius = 10
        layout_img.backgroundColor = .lightLightGray
        layout_img.clipsToBounds = true
        layout_img.translatesAutoresizingMaskIntoConstraints = false
        layout_img.isUserInteractionEnabled = true
        
        layout_img.addSubview(img_iconIMG)
        img_iconIMG.snp.makeConstraints() { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
        img_iconIMG.image = UIImage(named: "iconIMG")
        
        txt_commName.snp.makeConstraints() { make in
            make.top.equalTo(layout_img.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(26)
            make.width.equalTo(338)
        }
        txt_commName.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        txt_commName.clearButtonMode = .whileEditing
        txt_commName.placeholder = "모임 이름 입력"
        
        line2.snp.makeConstraints() { make in
            make.top.equalTo(txt_commName.snp.bottom).offset(11)
            make.width.equalTo(338)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        line2.backgroundColor = .semiLightGray
        
        label_setInvitation.snp.makeConstraints() { make in
            make.top.equalTo(line2.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(23)
        }
        label_setInvitation.text = "초대 설정"
        label_setInvitation.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label_setInvitation.sizeToFit()
        
        btn_invitation.snp.makeConstraints() { make in
            make.top.equalTo(label_setInvitation.snp.bottom).offset(22)
            make.width.equalTo(338)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        setSegmentedCustom(btn_invitation)
        
        label_setInvitationDescription.snp.makeConstraints() { make in
            make.top.equalTo(btn_invitation.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        label_setInvitationDescription.text = "일부 가입을 허용할 경우 가입 신청 시 모임장이 가입 허용 여부를 결정 가능 합니다."
        label_setInvitationDescription.textColor = .textLightGray
        label_setInvitationDescription.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label_setInvitationDescription.numberOfLines = 0
        
        label_limit.snp.makeConstraints() { make in
            make.top.equalTo(label_setInvitationDescription.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(23)
        }
        label_limit.text = "인원 제한"
        label_limit.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        btn_limit.snp.makeConstraints() { make in
            make.top.equalTo(label_limit.snp.bottom).offset(27)
            make.width.equalTo(338)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        setSegmentedCustom(btn_limit)
        
        label_limitDescription.snp.makeConstraints() {make in
            make.top.equalTo(btn_limit.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        label_limitDescription.text = "무제한을 선택하기 위해서는 해당 모임에 대해 책갈피 프리미엄 구독이 필요 합니다."
        label_limitDescription.textColor = .textLightGray
        label_limitDescription.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label_limitDescription.numberOfLines = 0
    }
    
    func setSegmentedCustom(_ segment: UISegmentedControl) {
        segment.selectedSegmentTintColor = .lightOrange
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.textBoldGray], for: .normal)
        segment.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segment.layer.borderColor = UIColor.semiLightGray.cgColor
        segment.layer.borderWidth = 1
        segment.layer.cornerRadius = 30
    }
}
