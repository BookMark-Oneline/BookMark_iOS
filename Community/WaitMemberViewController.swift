//
//  WaitMemberViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/29.
//
import UIKit

class WaitMemberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let layout_waits = WaitMembers()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviLayout()
        layout_waits.initView(view: self.view)
        layout_waits.layout_waits.delegate = self
        layout_waits.layout_waits.dataSource = self
    }
    
    //NavigationView
    func naviLayout() {
        self.navigationController?.navigationBar.topItem?.title = "가입 요청"
    }
    
 
}
// MARK: - TableView Delegate & Datasource
extension WaitMemberViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WaitMemberCell", for: indexPath) as? WaitMemeberTableViewCell else { return WaitMemeberTableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - TableView Layout
class WaitMembers {
    var layout_waits: UITableView = {
        let layout_waits = UITableView()
        layout_waits.register(WaitMemeberTableViewCell.self, forCellReuseIdentifier: WaitMemeberTableViewCell.identifier)
        layout_waits.backgroundColor = .white
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(layout_avatarImg, label_introduce, label_name, button_deny, button_accept)
        
        layout_avatarImg.snp.makeConstraints{ make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25)
        }
        layout_avatarImg.backgroundColor = .gray
        layout_avatarImg.layer.cornerRadius = 30
        
        label_name.snp.makeConstraints{ make in
            make.width.equalTo(210)
            make.height.equalTo(20)
            make.left.equalTo(layout_avatarImg.snp.right).offset(10)
            make.top.equalToSuperview().offset(25)
        }
        label_name.text = "NickName"
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
        
        button_accept.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo(27)
            make.height.equalTo(27)
        }
        button_accept.setImage(UIImage(named: "group_accept"), for: .normal)
        
        button_deny.snp.makeConstraints { make in
            make.centerY.equalTo(button_accept)
            make.right.equalTo(button_accept.snp.left).offset(-20)
            make.width.equalTo(27)
            make.height.equalTo(27)
        }
        button_deny.setImage(UIImage(named: "group_delete"), for: .normal)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
