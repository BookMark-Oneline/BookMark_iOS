//
//  CommunityMemberViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/29.
//
import UIKit
import SnapKit

class CommunityMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let layout_member = Members()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviLayout()
        layout_member.initViews(view: self.view)
        layout_member.layout_members.dataSource = self
        layout_member.layout_members.delegate = self
        
    }
    
    // NavigationView
    func naviLayout() {
        self.navigationController?.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.topItem?.title = "모임 인원"
        self.navigationController?.navigationBar.tintColor = .black
        
        let requestBtn = UIBarButtonItem(image: UIImage(named: "request"), style: .plain, target: self, action: nil)
        requestBtn.width = 27
        
        self.navigationItem.rightBarButtonItem = requestBtn
    }

}
// MARK: - TableView Datasource & Delegate
extension CommunityMemberViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupIdTableViewCell.identifier, for: indexPath) as? GroupIdTableViewCell else { return GroupIdTableViewCell() }
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemeberTableViewCell.identifier, for: indexPath) as? MemeberTableViewCell else { return MemeberTableViewCell() }
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 35
        } else {
            return 90
        }
    }
}

// MARK: - Performing TableView
class Members {
    var layout_members: UITableView = {
        let layout_memebers = UITableView()
        layout_memebers.backgroundColor = .white
        layout_memebers.register(GroupIdTableViewCell.self, forCellReuseIdentifier: GroupIdTableViewCell.identifier)
        layout_memebers.register(MemeberTableViewCell.self, forCellReuseIdentifier: MemeberTableViewCell.identifier)
        layout_memebers.translatesAutoresizingMaskIntoConstraints = false
        layout_memebers.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return layout_memebers
    }()
    
    func initViews(view: UIView) {
        view.addSubview(layout_members)
        
        layout_members.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



// MARK: - Member Cell Layout
class MemeberTableViewCell: UITableViewCell {
    static let identifier = "MemberCell"
    let layout_avatarImg = UIImageView()
    let label_name = UILabel()
    let label_introduce = UILabel()
    let layout_isReadingImg = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(layout_avatarImg, label_name, label_introduce, layout_isReadingImg)
        
        layout_avatarImg.snp.makeConstraints{ make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(22)
        }
        layout_avatarImg.backgroundColor = .gray
        layout_avatarImg.layer.cornerRadius = 30
        
        label_name.snp.makeConstraints{ make in
            make.width.equalTo(210)
            make.height.equalTo(20)
            make.left.equalTo(layout_avatarImg.snp.right).offset(10)
            make.top.equalToSuperview().offset(25)
        }
        label_name.text = "Nick Name"
        label_name.font = .systemFont(ofSize: 16)
        label_name.textColor = .black
        label_name.lineBreakMode = .byTruncatingTail
        
        label_introduce.snp.makeConstraints { make in
            make.width.equalTo(210)
            make.height.equalTo(15)
            make.left.equalTo(label_name.snp.left)
            make.top.equalTo(label_name.snp.bottom).offset(5)
        }
        label_introduce.text = "This is introduce"
        label_introduce.font = .systemFont(ofSize: 12)
        label_introduce.textColor = .textGray
        label_introduce.lineBreakMode = .byTruncatingTail
        
        layout_isReadingImg.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-22)
        }
        layout_isReadingImg.image = UIImage(named: "mylib_tab")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Group ID Cell Layout
class GroupIdTableViewCell: UITableViewCell {
    static let identifier = "GroupIdCell"
    let label_title = UILabel()
    let label_groupId = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(label_title, label_groupId)
        
        label_title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(23)
        }
        label_title.layer.cornerRadius = 10
        label_title.layer.borderColor = UIColor(red: 255/256, green: 179/256, blue: 90/256, alpha: 1).cgColor
        label_title.layer.borderWidth = 1
        label_title.text = "책모임 ID"
        label_title.font = .systemFont(ofSize: 10)
        label_title.textAlignment = .center
        label_title.textColor = UIColor(red: 249/256, green: 144/256, blue: 48/256, alpha: 1)
        
        label_groupId.snp.makeConstraints { make in
            make.centerY.equalTo(label_title)
            make.left.equalTo(label_title.snp.right).offset(11)
            make.right.equalToSuperview()
            make.height.equalTo(15)
        }
        label_groupId.text = "5S75FFG42"
        label_groupId.textColor = .black
        label_groupId.font = .systemFont(ofSize: 12)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
