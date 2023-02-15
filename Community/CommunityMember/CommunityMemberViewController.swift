//
//  CommunityMemberViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/29.
//
import UIKit
import SnapKit

class CommunityMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var clubID: Int = 1
    let network = Network()
    let layout_member = CommunityMemberView()
    private var memberList = [[String]]() // [user name, now reading, message, user images]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavCustom()
        getCommunityMember()
        
        layout_member.initViews(view: self.view)
        layout_member.layout_members.dataSource = self
        layout_member.layout_members.delegate = self
    }
    
    func setNavCustom() {
        self.setNavigationCustom(title: "모임 인원")
        self.setNavigationImageButton(imageName: ["message"], action: [#selector(pushJoinCommunityRequest)])
    }
    
    @objc func pushJoinCommunityRequest(_ sender: UIBarButtonItem) {
        let vc = WaitMemberViewController()
        vc.clubID = self.clubID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TableView Datasource & Delegate
extension CommunityMemberViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupIdTableViewCell.identifier, for: indexPath) as? GroupIdTableViewCell else { return GroupIdTableViewCell() }
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemeberTableViewCell.identifier, for: indexPath) as? MemeberTableViewCell else {
                return MemeberTableViewCell() }

            if (self.memberList.count == 0) {return cell}

            cell.label_name.text = self.memberList[indexPath.row - 1][0]
            cell.label_introduce.text = self.memberList[indexPath.row - 1][2]
            cell.layout_avatarImg.setImageUrl(url: self.memberList[indexPath.row - 1][3])
            if (self.memberList[indexPath.row - 1][1] == "0") {
                cell.layout_isReadingImg.image = UIImage(named: "bookmark_unclicked")
            }
            else {
                cell.layout_isReadingImg.image = UIImage(named: "bookmark_clicked")
            }

            return cell
        }
    }

    func tableView(_ tableViesw: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberList.count + 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 35
        default:
            return 99
        }
    }
}

// MARK: - 네트워크 용 extension
extension CommunityMemberViewController {
    func getCommunityMember() {
        network.getCommunityUserInfo(clubID: self.clubID, completion: { res in
            switch res {
            case .success(let members):
                guard let member = (members as? [CommunityUserList]) else {return}
                member.forEach { item in
                    self.memberList.append([item.user_name, String(describing: item.now_reading), item.introduce_message, item.img_url ?? ""])
                }
                self.layout_member.layout_members.reloadData()
            default:
                print("failed")
            }
        })
    }
}

// MARK: - Performing TableView
class CommunityMemberView {
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
        view.backgroundColor = .white
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
        self.selectionStyle = .none
        addSubviews(layout_avatarImg, label_name, label_introduce, layout_isReadingImg)
        
        layout_avatarImg.snp.makeConstraints{ make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(22)
        }
        layout_avatarImg.image = UIImage(named: "haerin.jpg")
        layout_avatarImg.clipsToBounds = true
        layout_avatarImg.backgroundColor = .gray
        layout_avatarImg.layer.cornerRadius = 30
        
        label_name.snp.makeConstraints{ make in
            make.width.equalTo(210)
            make.height.equalTo(20)
            make.left.equalTo(layout_avatarImg.snp.right).offset(10)
            make.top.equalToSuperview().offset(25)
        }
        label_name.text = "이름없음"
        label_name.font = .systemFont(ofSize: 16)
        label_name.textColor = .black
        label_name.lineBreakMode = .byTruncatingTail
        
        label_introduce.snp.makeConstraints { make in
            make.width.equalTo(210)
            make.height.equalTo(15)
            make.left.equalTo(label_name.snp.left)
            make.top.equalTo(label_name.snp.bottom).offset(5)
        }
        label_introduce.text = "소개없음"
        label_introduce.font = .systemFont(ofSize: 12)
        label_introduce.textColor = .textGray
        label_introduce.lineBreakMode = .byTruncatingTail
        
        layout_isReadingImg.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-22)
        }
        layout_isReadingImg.image = UIImage(named: "bookmark_unclicked")
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
        self.selectionStyle = .none
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
        }
        label_groupId.text = "5S75FFG42"
        label_groupId.textColor = .black
        label_groupId.font = .systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
