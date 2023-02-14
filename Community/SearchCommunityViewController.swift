//
//  SearchCommunityViewController.swift
//  BookMark
//
//  Created by BoMin on 2023/01/27.
//

import UIKit

class SearchCommunityViewController: UIViewController {
    
    var inputCommunityID: String = "default"
    
    let descriptLabel: UILabel = {
        let label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: 227, height: 63)
        label.textColor = .black
        label.text = "새로운\n책 모임을 만나보세요"
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 2
        
        let attributedStr = NSMutableAttributedString(string: label.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.textOrange, range: (label.text! as NSString).range(of: "모임"))
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    lazy var inputIDtextField: UITextField = {
        let field = UITextField()
        
        field.frame = CGRect(x: 0, y: 0, width: 344, height: 17)
        field.placeholder = "책모임 ID 입력"
        field.returnKeyType = .search
        field.autocorrectionType = .no
        field.delegate = self
        
        return field
    }()
    
    let tfLine: UIView = {
        let view = UIView()

        view.frame = CGRect(x: 0, y: 0, width: 338, height: 1)
        view.backgroundColor = .semiLightGray

        return view
    }()
    
    let searchButton: UIButton = {
        let btn = UIButton()
        
        btn.frame = CGRect(x: 0, y: 0, width: 166, height: 50)
        btn.backgroundColor = .lightOrange
        btn.setTitle("검색하기", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(searchButtonPress), for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        self.setNavigationCustom(title: "모임 검색하기")
    }
    
    @objc func searchButtonPress() {
        inputCommunityID = inputIDtextField.text ?? "default"
        print("모임 검색하기, 모임 ID :", inputCommunityID)
//        tfLine.lineFillAnimation()
        let vc = JoinCommunityRequestViewController()
        self.navigationController?.pushViewControllerTabHidden(vc, animated: true)
        vc.clubID = inputCommunityID
    }
    
}

extension SearchCommunityViewController {
    func setLayouts() {
        view.backgroundColor = .white
        view.addSubviews(descriptLabel, inputIDtextField, tfLine, searchButton)
        
        descriptLabel.snp.makeConstraints() { make in
            make.width.equalTo(227)
            make.height.equalTo(63)
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(135)
        }
        
        inputIDtextField.snp.makeConstraints() { make in
            make.width.equalTo(344)
            make.height.equalTo(17)
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(descriptLabel.snp.bottom).offset(44)
        }
        
        tfLine.snp.makeConstraints() { make in
            make.width.equalTo(338)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(inputIDtextField.snp.bottom).offset(11)
        }
        
        searchButton.snp.makeConstraints() { make in
            make.width.equalTo(166)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(tfLine.snp.bottom).offset(25)
        }
    }

//    func lineFillAnimation() { // UIView Extension에 추가해야 함.
//        let layer = CAGradientLayer()
//        let startLocations = [0, 0]
//        let endLocations = [1, 2]
//
//        layer.colors = [UIColor.lightOrange.cgColor, UIColor.semiLightGray.cgColor]
//        layer.frame = self.frame
//        layer.locations = startLocations as [NSNumber]
//        layer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        self.layer.addSublayer(layer)
//
//        let anim = CABasicAnimation(keyPath: "locations")
//        anim.fromValue = startLocations
//        anim.toValue = endLocations
//        anim.duration = 2.0
//        layer.add(anim, forKey: "loc")
//        layer.locations = endLocations as [NSNumber]
//    }
}

extension SearchCommunityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.searchButtonPress()
        return true
    }
}
