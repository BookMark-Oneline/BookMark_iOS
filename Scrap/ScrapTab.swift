//
//  ScrapTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit
import SnapKit

// MARK: - 스크랩 북 탭
class ScrapTab: UIViewController {

    let layout_beforeScrapServiceView = BeforeScrapServiceView()
    override func viewDidLoad() {
        super.viewDidLoad()

        layout_beforeScrapServiceView.initViews(self.view)
        // Do any additional setup after loading the view.
    }

}

// MARK: - 출시 예정 뷰
class BeforeScrapServiceView {
    let layout_main = UIView()
    let label_title = UILabel()
    let line1 = UIView()
    let img_beforeRelease = UIImageView()
    let label_beforeRelease = UILabel()
    let label_description = UILabel()
    func initViews(_ superView: UIView) {
        superView.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(superView.safeAreaLayoutGuide)
        }
        layout_main.addSubviews(img_beforeRelease, label_title, line1, label_beforeRelease, label_description)
        label_title.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(23)
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }
        label_title.text = "스크랩 북"
        label_title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        line1.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        line1.backgroundColor = .lightGray
        
        img_beforeRelease.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-70)
            make.width.equalTo(206)
            make.height.equalTo(87)
        }
        img_beforeRelease.image = UIImage(named: "comingsoon")
        
        label_beforeRelease.snp.makeConstraints() { make in
            make.top.equalTo(img_beforeRelease.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
        }
        label_beforeRelease.text = "서비스가 곧 출시될 예정이에요"
        label_beforeRelease.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        label_description.snp.makeConstraints() { make in
            make.top.equalTo(label_beforeRelease.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }
        label_description.numberOfLines = 0
        label_description.text = "스크랩 서비스는 아직 준비 중에 있어요\n조금만 기다려주세요!"
        label_description.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label_description.textAlignment = .center
        label_description.textColor = .textGray
        
    }
    
}
