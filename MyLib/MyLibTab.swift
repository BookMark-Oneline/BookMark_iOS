//
//  MyLibTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit
import SnapKit

// MARK: - 나의 서재 탭
class MyLibTab: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var books = [["addbook", "", ""], ["", "제목 1", "작가 1"], ["", "제목 2", "작가 2"], ["", "제목 3", "작가 3"], ["", "제목 4", "작가 4"], ["", "제목 5", "작가 5"], ["", "제목 6", "작가 6"], ["", "제목제목제목제목", "작가작가작가작가작가"], ["", "제목제목제목제목", "작가작가작가작가작가"], ["", "제목제목제목제목제목제목제목제목", "작가작가작가작가작가작가작가작가작가작가"], ["", "제목제목제목제목제목제목제목제목", "작가작가작가작가작가작가작가작가작가작가"]]
    let layout = layout_MyLibTab()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.initViews(view: self.view)
        layout.layout_collection.layout_books.delegate = self
        layout.layout_collection.layout_books.dataSource = self
    }
}

// MARK: - collection view 데이터 연결
extension MyLibTab {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as? BookCollectionCell else {
            return BookCollectionCell()
        }
        let book = self.books[indexPath.row]
        
        if (book[0] == "addbook") {
            cell.layout_img.image = UIImage(named: "addBook")
            cell.label_title.text = ""
            cell.label_author.text = ""
        }
        
        else {
            cell.layout_img.image = UIImage(named: book[0])
            cell.label_title.text = book[1]
            cell.label_author.text = book[2]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
}

// MARK: - layout class
class layout_MyLibTab {
    var layout_main = UIView()
    
    var layout_title = UIView()
    var label_title = UILabel()
    
    var layout_scroll = UIScrollView()
    
    var layout_profile = UIView()
    var layout_circle = UIView()
    var img_profile = UIImageView()
    var label_name = UILabel()
    
    var label_books = UILabel()
    var label_bookcount = UILabel()
    var label_time = UILabel()
    var label_timecount = UILabel()
    
    var layout_collectionview = UIView()
    var layout_collection = layout_books()
    
    func initViews(view: UIView) {
        view.addSubviews(layout_title, layout_scroll)
        layout_title.snp.makeConstraints() { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        layout_title.addSubview(label_title)
        label_title.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
        }
        label_title.textColor = .black
        label_title.text = "책갈피: 오늘 한줄"
        label_title.font = UIFont.boldSystemFont(ofSize: 18)
        
        layout_scroll.translatesAutoresizingMaskIntoConstraints = false
        layout_scroll.snp.makeConstraints() { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(layout_title.snp.bottom)
        }
        layout_scroll.frameLayoutGuide.snp.makeConstraints() { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(layout_title.snp.bottom)
        }
        layout_scroll.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.top.leading.trailing.bottom.equalTo(layout_scroll.contentLayoutGuide)
            make.size.equalToSuperview()
        }
        
        layout_main.addSubviews(layout_profile, layout_collectionview)
        layout_profile.snp.makeConstraints() { make in
            make.top.equalTo(layout_title.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        layout_profile.addSubviews(layout_circle, label_name, label_books, label_bookcount, label_time, label_timecount)
        layout_circle.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
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
            make.top.equalTo(layout_circle.snp.bottom).offset(10)
            make.centerX.equalTo(layout_circle)
        }
        label_name.text = "페페"
        label_name.font = UIFont.systemFont(ofSize: 15)
        label_name.sizeToFit()
        
        label_books.snp.makeConstraints() { make in
            make.trailing.equalTo(layout_circle.snp.leading).offset(-59)
            make.top.equalToSuperview().offset(39)
        }
        label_books.text = "읽은 책"
        label_books.font = UIFont.systemFont(ofSize: 13)
        label_books.textColor = .textGray
        label_books.sizeToFit()
        
        label_bookcount.snp.makeConstraints() { make in
            make.centerX.equalTo(label_books)
            make.top.equalTo(label_books.snp.bottom).offset(10)
        }
        label_bookcount.text = "36"
        label_bookcount.font = UIFont.boldSystemFont(ofSize: 16)
        label_bookcount.textColor = .black
        label_bookcount.sizeToFit()
        
        label_time.snp.makeConstraints() { make in
            make.leading.equalTo(layout_circle.snp.trailing).offset(41)
            make.centerY.equalTo(label_books)
        }
        label_time.text = "평균 독서시간"
        label_time.font = UIFont.systemFont(ofSize: 13)
        label_time.textColor = .textGray
        label_time.sizeToFit()
        
        label_timecount.snp.makeConstraints() { make in
            make.centerX.equalTo(label_time)
            make.centerY.equalTo(label_bookcount)
        }
        label_timecount.text = "1h 45m"
        label_timecount.font = UIFont.boldSystemFont(ofSize: 16)
        label_timecount.textColor = .black
        label_timecount.sizeToFit()
        
        layout_collectionview.snp.makeConstraints() { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(layout_profile.snp.bottom)
        }
        layout_collection.initViews(view: layout_collectionview)
        
        
    }
}


// MARK: - scroll view + collection view
class layout_books {
    var label_mylib = UILabel()
    var label_bookcount = UILabel()
    var layout_books: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 104, height: 184)
        
        let layout_books = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout_books.backgroundColor = .white
        layout_books.register(BookCollectionCell.self, forCellWithReuseIdentifier: "bookcell")
        layout_books.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 67, right: 8)
        layout_books.translatesAutoresizingMaskIntoConstraints = false
        
        return layout_books
    }()
    
    func initViews(view: UIView) {
        view.addSubviews(label_mylib, label_bookcount, layout_books)
        
        label_mylib.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.top.equalToSuperview().offset(20)
        }
        label_mylib.text = "나의 서재"
        label_mylib.textColor = .black
        label_mylib.font = UIFont.boldSystemFont(ofSize: 17)
        label_mylib.sizeToFit()
        
        label_bookcount.snp.makeConstraints() { make in
            make.leading.equalTo(label_mylib.snp.trailing).offset(5)
            make.centerY.equalTo(label_mylib)
        }
        label_bookcount.font = UIFont.systemFont(ofSize: 14)
        label_bookcount.textColor = .textGray
        label_bookcount.text = "36"
        
        layout_books.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(label_mylib.snp.bottom).offset(18)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
}

// MARK: - scroll view cell class
class BookCollectionCell: UICollectionViewCell {
    static let identifier = "bookcell"
    let layout_img = UIImageView()
    let label_title = UILabel()
    let label_author = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(layout_img, label_title, label_author)
        layout_img.snp.makeConstraints() { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(104)
            make.height.equalTo(139.17)
        }
        layout_img.backgroundColor = UIColor(Hex: 0xE3E3E3)
        layout_img.layer.cornerRadius = 3
        
        label_title.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalTo(layout_img.snp.bottom).offset(7)
            make.width.equalTo(100)
            make.height.equalTo(19.84)
        }
        label_title.text = "제목"
        label_title.font = UIFont.boldSystemFont(ofSize: 14)
        label_title.textColor = .black
        label_title.lineBreakMode = .byTruncatingTail
        
        label_author.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalTo(label_title.snp.bottom).offset(1)
            make.width.equalTo(100)
            make.height.equalTo(15.87)
        }
        label_author.text = "작가"
        label_author.font = UIFont.systemFont(ofSize: 12)
        label_author.textColor = .textGray
        label_author.lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
