//
//  OneLineTabView.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/09.
//

import UIKit
import SnapKit

// MARK: - 오늘 한 줄 tab view
class OneLineTabView {
    let layout_main = UIView()
    let label_title = UILabel()
    let btn_create = UIButton()
    let img_background = UIImageView()
    let layout_black = UIView()
    let label_oneline = UILabel()
    let layout_line = UIView()
    let img_profile = UIImageView()
    let label_name = UILabel()
    let label_time = UILabel()
    let btn_more = UIButton()

    func initViews(_ superView: UIView) {
        superView.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.top.equalTo(superView)
            make.leading.trailing.bottom.equalTo(superView.safeAreaLayoutGuide)
        }
        layout_main.isUserInteractionEnabled = true
        layout_main.addSubviews(label_title, btn_create, img_background, layout_black, label_oneline, layout_line, img_profile, label_name, label_time, btn_more)
        
        label_title.snp.makeConstraints() { make in
            make.top.equalTo(superView.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(23)
        }
        label_title.sizeToFit()
        label_title.setTxtAttribute("책갈피 : 오늘 한 줄", size: 18, weight: .bold, txtColor: .white)
        label_title.layer.zPosition = 999
        
        btn_create.snp.makeConstraints() { make in
            make.centerY.equalTo(label_title)
            make.size.equalTo(22)
            make.right.equalToSuperview().offset(-23)
        }
        btn_create.layer.zPosition = 999
        btn_create.setImage(UIImage(systemName: "plus"), for: .normal)
        btn_create.tintColor = .white
        
        img_background.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
        img_background.image = UIImage(named: "backImg")
        img_background.contentMode = .scaleAspectFill

        layout_black.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
        layout_black.isUserInteractionEnabled = false
        layout_black.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)

        label_oneline.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview().inset(23)
            make.centerY.equalTo(superView.safeAreaLayoutGuide.snp.centerY).inset(10)
        }
        label_oneline.numberOfLines = 0
        label_oneline.textAlignment = .center
        label_oneline.layer.zPosition = 999
        label_oneline.setTxtAttribute("사랑에는 늘 약간의 망상이 들어 있다.\n\n차라투스트라는 이렇게 말했다, 프리드리히 니체", size: 16, weight: .medium, txtColor: .white)
        
        layout_line.snp.makeConstraints() { make in
            make.bottom.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview().inset(23)
            make.height.equalTo(1)
        }
        layout_line.backgroundColor = .white

        img_profile.snp.makeConstraints() { make in
            make.top.equalTo(layout_line.snp.bottom).offset(7)
            make.leading.equalTo(layout_line)
            make.size.equalTo(30)
        }
        img_profile.clipsToBounds = true
        img_profile.layer.cornerRadius = 15
        img_profile.image = UIImage(named: "pepe.jpg")

        label_name.snp.makeConstraints() { make in
            make.centerY.equalTo(img_profile)
            make.leading.equalTo(img_profile.snp.trailing).offset(7)
        }
        label_name.sizeToFit()
        label_name.layer.zPosition = 999
        label_name.setTxtAttribute(UserInfo.shared.userName ?? "", size: 14, weight: .semibold, txtColor: .white)

        label_time.snp.makeConstraints() { make in
            make.centerY.equalTo(label_name)
            make.leading.equalTo(label_name.snp.trailing).offset(7)
        }
        label_time.setTxtAttribute("2시간전", size: 11, weight: .medium, txtColor: .lightGray)
        label_time.layer.zPosition = 999
        
        btn_more.snp.makeConstraints() { make in
            make.centerY.equalTo(img_profile)
            make.size.equalTo(20)
            make.right.equalToSuperview().offset(-23)
        }
        btn_more.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn_more.tintColor = .white
        
    }
    
}
