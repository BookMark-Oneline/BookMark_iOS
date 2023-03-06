//
//  SearchCommunityViewController.swift
//  BookMark
//
//  Created by BoMin on 2023/01/27.
//

import UIKit

class SearchCommunityViewController: UIViewController {
    var inputCommunityID: Int = 0
    
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
        btn.setTitle("검색하기", size: 17, weight: .bold, color: .white)
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
        inputCommunityID = Int(inputIDtextField.text ?? "0") ?? 0
        let vc = JoinCommunityRequestViewController()
        vc.clubID = inputCommunityID
        self.navigationController?.pushViewControllerTabHidden(vc, animated: true)
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
}

extension SearchCommunityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.searchButtonPress()
        return true
    }
}
