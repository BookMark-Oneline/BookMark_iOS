//
//  MyPageTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit

// MARK: - 마이 페이지 탭
class MyPageTab: UIViewController {
    let label_title = UILabel()
    let line = UIView()
    private let tableView: UITableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBase()
    }
    
    private func setUpBase() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCells()
        self.view.addSubviews(label_title, line, tableView)
        self.tableView.separatorStyle = .none
        
        label_title.snp.makeConstraints() { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(23)
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }
        label_title.text = "마이페이지"
        label_title.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        line.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        line.backgroundColor = .lightGray

        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

extension MyPageTab: UITableViewDataSource, UITableViewDelegate {
    private func registerCells() {
        self.tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        self.tableView.register(MyPageCell.self, forCellReuseIdentifier: "MyPageCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "ProfileCell") ?? UITableViewCell()
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            setCellAttribute(cell, title: "알림 설정", isButton: true, isSwitch: false)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            self.setCellAttribute(cell, title: "정보 공유 설정", isButton: true, isSwitch: false)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            self.setCellAttribute(cell, title: "목표 독서 시간 설정", isButton: true, isSwitch: false)
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            self.setCellAttribute(cell, title: "구독 내역", isButton: true, isSwitch: false)
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            self.setCellAttribute(cell, title: "계정 비공개", isButton: false, isSwitch: true)
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            self.setCellAttribute(cell, title: "개인 정보 보호", isButton: false, isSwitch: false)
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            self.setCellAttribute(cell, title: "로그아웃", isButton: false, isSwitch: false)
            return cell
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") else { return UITableViewCell() }
            self.setCellAttribute(cell, title: "회원 탈퇴", isButton: false, isSwitch: false, txtColor: .red)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            self.navigationController?.pushViewControllerTabHidden(SetTimeGoalViewController(), animated: true)
        default:
            return
        }
    }
    
    private func setCellAttribute(_ sender: UITableViewCell, title: String, isButton: Bool, isSwitch: Bool, txtColor: UIColor = .black) {
        guard let cell = sender as? MyPageCell else {return}
        cell.selectionStyle = .none
        cell.title.text = title
        cell.title.textColor = txtColor
        if (isButton && !isSwitch) {
            cell.switchs.isHidden = true
        }
        else if (!isButton && isSwitch) {
            cell.btn.isHidden = true
        }
        else {
            cell.btn.isHidden = true
            cell.switchs.isHidden = true
        }
    }
}

// MARK: - 프로필 cell
class ProfileCell: UITableViewCell {
    var layout_circle = UIView()
    var img_profile = UIImageView()
    var label_name = UILabel()
    var label_message = UILabel()
    let btn_settingProfile = UIButton()
    let line = UIView()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ProfileCell")
        setBaseView()
    }
    
    private func setBaseView() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = true
        self.contentView.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(175)
        }
        self.contentView.addSubviews(layout_circle, img_profile, label_name, label_message, btn_settingProfile, line)
        
        layout_circle.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(23)
            make.size.equalTo(85)
        }
        layout_circle.layer.cornerRadius = 81 / 2.0
        layout_circle.translatesAutoresizingMaskIntoConstraints = false
        layout_circle.layer.borderWidth = 1.1
        layout_circle.layer.borderColor = UIColor.lightGray.cgColor
        
        layout_circle.addSubview(img_profile)
        img_profile.snp.makeConstraints() { make in
            make.size.equalTo(75)
            make.center.equalToSuperview()
        }
        img_profile.layer.cornerRadius = 75 / 2.0
        img_profile.image = UIImage(named: "pepe.jpg")
        img_profile.clipsToBounds = true
        img_profile.translatesAutoresizingMaskIntoConstraints = false
        
        label_name.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(43)
            make.leading.equalTo(layout_circle.snp.trailing).offset(14)
        }
        label_name.text = "독서왕페페"
        label_name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label_name.sizeToFit()
        
        label_message.snp.makeConstraints() { make in
            make.top.equalTo(label_name.snp.bottom).offset(7)
            make.leading.equalTo(label_name)
            make.trailing.equalToSuperview().offset(-23)
        }
        label_message.text = "올해의 목표는 100권"
        label_message.textAlignment = .left
        label_message.lineBreakMode = .byTruncatingTail
        label_message.textColor = .textLightGray
        label_message.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        btn_settingProfile.snp.makeConstraints() { make in
            make.top.equalTo(img_profile.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            make.height.equalTo(35)
        }
        btn_settingProfile.setTitle("프로필 설정", for: .normal)
        btn_settingProfile.setTitleColor(.textBoldGray, for: .normal)
        btn_settingProfile.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        btn_settingProfile.layer.borderWidth = 1
        btn_settingProfile.layer.borderColor = UIColor.semiLightGray.cgColor
        btn_settingProfile.layer.cornerRadius = 6
        
        line.snp.makeConstraints() { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        line.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 마이 페이지 table cell
class MyPageCell: UITableViewCell {
    let title = UILabel()
    let btn = UIImageView()
    let switchs = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MyPageCell")
        setBaseView()
    }
    
    private func setBaseView() {
        self.contentView.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
        }
        self.contentView.addSubviews(btn, switchs, title)

        btn.snp.makeConstraints() { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(6)
            make.height.equalTo(12)
            make.right.equalToSuperview().offset(-24)
        }
        btn.image = UIImage(named: "right")

        switchs.snp.makeConstraints() { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
        }
        switchs.onTintColor = .lightOrange

        title.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
        }
        title.text = ""
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
