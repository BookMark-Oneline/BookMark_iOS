//
//  MyLibTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit
import SnapKit
import Kingfisher

// MARK: - 나의 서재 탭
class MyLibTab: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let layout = MyLibTabView()
    let network = Network()
    
    var books: [[String]] = [["0", "addbook", "", ""]]
    override func viewDidLoad() {
        super.viewDidLoad()
        getShelfData()

        layout.layout_collection.layout_books.delegate = self
        layout.layout_collection.layout_books.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        dataReload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func dataReload(status: Int = 1) {
        // 데이터 새로 추가
        if (status == 0) {
            if let appdel = UIApplication.shared.delegate as? AppDelegate {
                appdel.books = self.books
            }
            layout.bookCount = self.books.count
            layout.initViews(view: self.view)
        }
        else {
            self.books = ((UIApplication.shared.delegate as? AppDelegate)?.books)!
        }
        layout.layout_collection.layout_books.reloadData()
    }
}

// MARK: - 네트워크 용 extension
extension MyLibTab {
    // 서재 데이터 get
    func getShelfData() {
        network.getShelf { response in
            switch response {
            case .success(let shelf):
                if let book = (shelf as? Shelf)?.data {
                    book.forEach({ item in
                        self.books.append(["\(item.book_id)", item.img_url, item.title, item.author])
                        self.layout.layout_collection.layout_books.reloadData()
                    })
                    self.dataReload(status: 0)
                }
            default:
                print("failed")
            }
        }
    }
}

// MARK: - collection view 데이터 연결: data source
extension MyLibTab {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as? BookCollectionCell else {
            return BookCollectionCell()
        }
        let book = self.books[indexPath.row]
        
        if (book[0] == "0" && book[1] == "addbook") {
            cell.layout_img.image = UIImage(named: "addBook")
            cell.label_title.text = ""
            cell.label_author.text = ""
            cell.tag = 0
        }
        
        else {
            cell.layout_img.kf.indicatorType = .activity
                         cell.layout_img.kf.setImage(with: URL(string: book[1]), placeholder: nil, options: [.transition(.fade(1)), .cacheOriginalImage, .forceTransition], completionHandler: nil)
            cell.bookid = book[0]
            cell.label_title.text = book[2]
            cell.label_author.text = book[3]
            cell.tag = 1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
}

// MARK: - collection view 반응 연결: delegate
extension MyLibTab {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? BookCollectionCell else {
            return
        }
        
        // 북 추가 화면 연결
        if (item.label_title.text == "" && item.label_author.text == "" && item.tag == 0) {
            self.navigationController?.pushViewControllerTabHidden(AddBookBarcodeViewController(), animated: true)
        }
        
        // 책 세부 내용 화면 연결
        else {
            let vc = BookDetailViewController()
            
            network.getBookDetail(bookId: item.bookid, completion: { response in
                switch response {
                case .success(let book):
                    if let book = book as? [BookDetail] {
                        vc.bookData = book[0]
                    }
                    self.navigationController?.pushViewControllerTabHidden(vc, animated: true)
                default:
                    print("failed")
                }
            })
        }
    }
}

// MARK: - layout class
class MyLibTabView {
    var layout_main = UIView()
    var bookCount: Int = 0
    
    var layout_title = UIView()
    var label_title = UILabel()
    var line1 = UIView()
    
    var layout_scroll = UIScrollView()
    
    var layout_profile = UIView()
    var layout_circle = UIView()
    var img_profile = UIImageView()
    var label_name = UILabel()
    
    var line2 = UIView()
    
    var label_books = UILabel()
    var label_bookcount = UILabel()
    var label_time = UILabel()
    var label_timecount = UILabel()
    
    var layout_collectionview = UIView()
    var layout_collection = Books()
    
    func initViews(view: UIView) {
        view.addSubviews(layout_title, layout_scroll)
        layout_title.snp.makeConstraints() { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        layout_title.addSubviews(label_title, line1)
        label_title.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
        }
        
        line1.snp.makeConstraints() { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        line1.backgroundColor = .lightGray
        
        label_title.textColor = .black
        label_title.text = "책갈피 : 나의 서재"
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
        
        layout_main.addSubviews(layout_profile, line2, layout_collectionview)
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
        label_bookcount.text = "\(bookCount)"
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
        
        line2.snp.makeConstraints() { make in
            make.top.equalTo(layout_profile.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(15)
        }
        line2.backgroundColor = .lightGray
        
        layout_collection.bookCount = self.bookCount
        layout_collectionview.snp.makeConstraints() { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(line2.snp.bottom)
        }
        layout_collection.initViews(view: layout_collectionview)
        
        
    }
}


// MARK: - scroll view + collection view
class Books {
    var bookCount: Int = 0
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
        label_bookcount.text = "\(bookCount)"
        
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
    var bookid = ""
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
        layout_img.backgroundColor = .lightLightGray
        layout_img.layer.cornerRadius = 3
        layout_img.clipsToBounds = true
        
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
