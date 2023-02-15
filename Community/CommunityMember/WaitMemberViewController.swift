//
//  WaitMemberViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/29.
//
import UIKit

class WaitMemberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let network = Network()
    let layout_waits = WaitMembersView()
    var clubID: Int = 1
    private var requestList = [[String]]() // [프로필 사진, 이름, 소개말, 아이디]

    override func viewDidLoad() {
        super.viewDidLoad()
        naviLayout()
        getRequestList()
        
        layout_waits.initView(view: self.view)
        layout_waits.layout_waits.delegate = self
        layout_waits.layout_waits.dataSource = self
    }
    
    func naviLayout() {
        self.navigationItem.title = "가입 요청"
        self.navigationController?.navigationBar.tintColor = .black
    }
}

// MARK: - TableView Delegate & Datasource
extension WaitMemberViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WaitMemberCell", for: indexPath) as? WaitMemeberTableViewCell else { return WaitMemeberTableViewCell() }
        
        cell.layout_avatarImg.setImageUrl(url: requestList[indexPath.row][0])
        cell.label_name.text = requestList[indexPath.row][1]
        cell.label_introduce.text = requestList[indexPath.row][2]
        
        cell.acceptCallbackMehtod = { [weak self] in
            self?.accpetJoinRequest(userID: self?.requestList[indexPath.row][3] ?? "", completion: {
                self?.layout_waits.layout_waits.deleteRows(at: [indexPath], with: .left)
            })
        }
        
        cell.declineCallbackMehtod = { [weak self] in
            self?.declineJoinRequest(userID: self?.requestList[indexPath.row][3] ?? "", completion: {
                self?.layout_waits.layout_waits.deleteRows(at: [indexPath], with: .left)
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requestList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - 네트워크 용 extension
extension WaitMemberViewController {
    func getRequestList() {
        network.getCommunityJoinRequestList(clubID: self.clubID, completion: { res in
            switch res {
            case .success(let members):
                guard let member = (members as? CommunityJoinRequest)?.membersRequesting else {return}
                member.forEach { item in
                    self.requestList.append([item.img_url, item.user_name, item.introduce_message, "\(item.user_id)"])
                }
                self.layout_waits.layout_waits.reloadData()
            default:
                self.view.makeToast("가입 요청자가 없습니다", duration: 1, position: .bottom)
                print("get failed")
            }
        })
    }
    
    func accpetJoinRequest(userID: String, completion: @escaping () -> Void) {
        let userid = Int(userID) ?? 0
        network.postCommunityJoinRequestStatus(userID: userid, clubID: self.clubID, completion: { res in
            switch res {
            case .success:
                self.view.makeToast("가입이 되었습니다", duration: 1, position: .bottom)
                completion()
            default:
                self.view.makeToast("가입 요청을 받을 수 없습니다\n 잠시 후 다시 시도해주세요", duration: 1, position: .bottom)
            }
        })
    }
    
    func declineJoinRequest(userID: String, completion: @escaping () -> Void) {
        let userid = Int(userID) ?? 0
        network.postCommunityJoinRequestDecline(userID: userid, clubID: self.clubID, completion: { res in
            switch res {
            case .success:
                self.view.makeToast("가입 거부 되었습니다", duration: 1, position: .bottom)
                completion()
            default:
                self.view.makeToast("가입 거부를 할 수 없습니다\n 잠시 후 다시 시도해주세요", duration: 1, position: .bottom)
            }
        })
    }
}

// MARK: - TableView Layout
class WaitMembersView {
    var layout_waits: UITableView = {
        let layout_waits = UITableView()
        layout_waits.register(WaitMemeberTableViewCell.self, forCellReuseIdentifier: WaitMemeberTableViewCell.identifier)
        layout_waits.translatesAutoresizingMaskIntoConstraints = false
        layout_waits.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return layout_waits
    }()
    
    func initView(view: UIView) {
        view.addSubview(layout_waits)
        
        layout_waits.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Requested Member Cell Layout
class WaitMemeberTableViewCell: UITableViewCell {
    static let identifier = "WaitMemberCell"
    let layout_avatarImg = UIImageView()
    let label_name = UILabel()
    let label_introduce = UILabel()
    let button_deny = UIButton()
    let button_accept = UIButton()
    var acceptCallbackMehtod: (() -> Void)?
    var declineCallbackMehtod: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubviews(layout_avatarImg, label_introduce, label_name, button_deny, button_accept)
        
        layout_avatarImg.snp.makeConstraints{ make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25)
        }
        layout_avatarImg.image = UIImage(named: "haerin.jpg")
        layout_avatarImg.backgroundColor = .gray
        layout_avatarImg.layer.cornerRadius = 30
        layout_avatarImg.clipsToBounds = true
        
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
        
        button_accept.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo(27)
            make.height.equalTo(27)
        }
        button_accept.setImage(UIImage(named: "group_accept"), for: .normal)
        button_accept.addTarget(self, action: #selector(didTapAcceptButton), for: .touchUpInside)
        
        button_deny.snp.makeConstraints { make in
            make.centerY.equalTo(button_accept)
            make.right.equalTo(button_accept.snp.left).offset(-20)
            make.width.equalTo(27)
            make.height.equalTo(27)
        }
        button_deny.setImage(UIImage(named: "group_delete"), for: .normal)
        button_deny.addTarget(self, action: #selector(didTapDeclineButton), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapAcceptButton(_ sender: UIButton) {
        acceptCallbackMehtod?()
    }
    
    @objc func didTapDeclineButton(_ sender: UIButton) {
        declineCallbackMehtod?()
    }
}
