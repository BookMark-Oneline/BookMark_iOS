//
//  PostDetailViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/31.
//

import UIKit

// MARK: - 게시글 확인 view controller
class PostDetailViewController: UIViewController {
    
    let layout_postDetail = postDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout_postDetail.initView(view: self.view)
        layout_postDetail.layout_postDetail.delegate = self
        layout_postDetail.layout_postDetail.dataSource = self
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPostCell.identifier, for: indexPath) as? MainPostCell else { return MainPostCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identfier, for: indexPath) as? CommentCell else { return CommentCell() }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170
        } else {
            return 85
        }
    }
    
}


class postDetail {
    var layout_postDetail : UITableView = {
        let layout_postDetail = UITableView()
        layout_postDetail.translatesAutoresizingMaskIntoConstraints = false
        layout_postDetail.register(MainPostCell.self, forCellReuseIdentifier: MainPostCell.identifier)
        layout_postDetail.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identfier)

        layout_postDetail.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout_postDetail
    }()
    
    func initView(view : UIView) {
        view.addSubview(layout_postDetail)
        
        layout_postDetail.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}





class MainPostCell: UITableViewCell {
    
    static let identifier = "mainCell"
    let layout_userImg = UIImageView()
    let label_author = UILabel()
    let label_time = UILabel()
    let label_title = UILabel()
    let label_context = UILabel()
    let btn_heart = UIButton()
    let label_heart = UILabel()
    let layout_comment = UIImageView()
    let label_comment = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(layout_userImg, label_author, label_time, label_title, label_context, btn_heart, label_heart, layout_comment, label_comment)
        
        layout_userImg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(23)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        layout_userImg.image = UIImage(named: "haerin.jpg")
        layout_userImg.clipsToBounds = true
        layout_userImg.layer.cornerRadius = 17.5
        layout_userImg.backgroundColor = .gray
        
        label_author.snp.makeConstraints { make in
            make.top.equalTo(layout_userImg)
            make.left.equalTo(layout_userImg.snp.right).offset(9)
            make.height.equalTo(16)
            make.right.equalToSuperview().offset(23)
        }
        label_author.text = "독서왕 김독서"
        label_author.textColor = .black
        label_author.font = .systemFont(ofSize: 13)
        label_author.textAlignment = .natural
        
        label_time.snp.makeConstraints { make in
            make.bottom.equalTo(layout_userImg)
            make.height.equalTo(11)
            make.left.equalTo(label_author)
        }
        label_time.text = "1/31 03:25"
        label_time.textColor = .textGray
        label_time.font = .systemFont(ofSize: 11)
        
        label_title.snp.makeConstraints { make in
            make.top.equalTo(label_time.snp.bottom).offset(13)
            make.left.equalTo(layout_userImg)
            make.right.equalToSuperview().offset(23)
        }
        label_title.text = "제목 예시입니다."
        label_title.font = .boldSystemFont(ofSize: 17)
        label_title.textColor = .black
        label_title.lineBreakStrategy = .standard
        label_title.numberOfLines = 0
        label_title.textAlignment = .natural
        
        label_context.snp.makeConstraints { make in
            make.top.equalTo(label_title.snp.bottom).offset(7)
            make.left.equalTo(layout_userImg)
            make.right.equalToSuperview().offset(23)
        }
        label_context.numberOfLines = 0
        label_context.font = .systemFont(ofSize: 12)
        label_context.textColor = .black
        label_context.text = "내용 예시입니다. 내용 예시입니다. 내용 예시입니다."
        label_title.lineBreakStrategy = .standard
        label_title.textAlignment = .natural
        
        btn_heart.snp.makeConstraints { make in
            make.left.equalTo(layout_userImg)
            make.top.equalTo(label_context.snp.bottom).offset(31)
            make.width.equalTo(21)
            make.height.equalTo(21)
        }
        btn_heart.setImage(UIImage(named: "heart"), for: .normal)
        
        label_heart.snp.makeConstraints { make in
            make.centerY.equalTo(btn_heart)
            make.left.equalTo(btn_heart.snp.right).offset(2)
        }
        label_heart.text = "10"
        label_heart.textColor = .red
        label_heart.font = .systemFont(ofSize: 11)
        label_heart.textAlignment = .natural
        
        layout_comment.snp.makeConstraints { make in
            make.centerY.equalTo(btn_heart)
            make.left.equalTo(label_heart.snp.right).offset(3)
            make.width.height.equalTo(21)
        }
        layout_comment.image = UIImage(named: "balloon")
        
        label_comment.snp.makeConstraints { make in
            make.centerY.equalTo(btn_heart)
            make.left.equalTo(layout_comment.snp.right).offset(2)
        }
        label_comment.text = "11"
        label_comment.textColor = .black
        label_comment.font = .systemFont(ofSize: 11)
        label_comment.textAlignment = .natural
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CommentCell: UITableViewCell {
    
    
    static let identfier = "commentCell"
    let layout_userImg = UIImageView()
    let label_author = UILabel()
    let label_context = UILabel()
    let label_time = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews(layout_userImg, label_author, label_context, label_time)
        
        
        layout_userImg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(23)
            make.width.height.equalTo(29)
        }
        layout_userImg.image = UIImage(named: "pepe.jpg")
        layout_userImg.clipsToBounds = true
        layout_userImg.backgroundColor = .gray
        layout_userImg.layer.cornerRadius = 14.5
        
        
        label_author.snp.makeConstraints { make in
            make.centerY.equalTo(layout_userImg)
            make.left.equalTo(layout_userImg.snp.right).offset(8)
            make.right.equalToSuperview().offset(23)
        }
        label_author.text = "댓글 작성자"
        label_author.font = .systemFont(ofSize: 13)
        label_author.textColor = .black
        label_author.textAlignment = .left
        
        label_context.snp.makeConstraints { make in
            make.left.right.equalTo(label_author)
            make.top.equalTo(label_author.snp.bottom).offset(8)
        }
        label_context.text = "댓글 예시입니다. 댓글 예시입니다."
        label_context.textColor = .black
        label_context.font = .systemFont(ofSize: 12)
        label_context.textAlignment = .natural
        label_context.lineBreakMode = .byTruncatingTail
        label_context.numberOfLines = 0
        
        label_time.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-23)
            make.top.equalTo(label_context.snp.bottom).offset(8)
        }
        label_time.text = "01/20 04:05"
        label_time.textColor = .textGray
        label_time.font = .systemFont(ofSize: 11)
        label_time.textAlignment = .right
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
