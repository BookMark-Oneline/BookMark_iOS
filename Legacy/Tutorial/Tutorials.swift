//
//  Tutorials.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/15.
//

import UIKit
import SnapKit

class TutorialBaseViewController: UIViewController{
    let label_title = UILabel()
    let label_description = UILabel()
    let img_tutorial = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(label_title, label_description, img_tutorial)
        label_title.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(159)
            make.centerX.equalToSuperview()
        }
        label_title.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        label_description.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
        label_description.numberOfLines = 0
    }
    
    func setTextAttribute(_ str: String) {
        let attrString = NSMutableAttributedString(string: str)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        attrString.addAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .semibold), .foregroundColor: UIColor.textBoldGray], range: NSMakeRange(0, attrString.length))
        self.label_description.attributedText = attrString
    }
}

class FirstPageViewController: TutorialBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label_title.text = "나의 서재"
        self.setTextAttribute("실제 나의 책장을 한 페이지에\n책을 정리하고 기록하세요.")
        
        self.img_tutorial.snp.makeConstraints() { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(332)
            make.width.equalTo(310)
        }
        self.img_tutorial.image = UIImage(named: "tutorial1")
    }
}

class SecondPageViewController: TutorialBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label_title.text = "나의 독서 그래프"
        self.setTextAttribute("날짜별로 나의 독서량을\n확인하고 기록하세요.")
        
        self.img_tutorial.snp.makeConstraints() { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(243)
            make.width.equalTo(251)
        }
        self.img_tutorial.image = UIImage(named: "tutorial2")
    }
}

class ThirdPageViewController: TutorialBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label_title.text = "책모임을 통한 소통"
        self.setTextAttribute("비슷한 취향의 사람들과\n소통해보세요.")
        
        self.img_tutorial.snp.makeConstraints() { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(325)
            make.width.equalTo(310)
        }
        self.img_tutorial.image = UIImage(named: "tutorial3")
    }
}

class FourthPageViewController: TutorialBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label_title.text = "한 줄의 독서, 오늘 한줄"
        self.setTextAttribute("책을 읽고 기억에 남았던\n문장을 공유해보세요.")
        
        self.img_tutorial.snp.makeConstraints() { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(332)
            make.width.equalTo(251)
        }
        self.img_tutorial.image = UIImage(named: "tutorial4")
    }
}
