//
//  ConfirmBookViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/07.
// Merge Again

import SnapKit
import UIKit
import Kingfisher

// MARK: - 책 확인 view controller
class ConfirmBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setConstraints()    
        getBookSearchAPI()
    }
    let layout_book = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publisherLabel = UILabel()
    let label_summary = UILabel()
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    let descriptionTextView = UILabel()
    let showallButton = UIButton()
    let showShortButton = UIButton()
    let contentView = UIView()
    let divideView = UIView()
    let upperDivideView = UIView()
    
    let network = Network()
    
    var isbnValue: String = "9788995151204"
    var bookTitle: String = ""
    var bookImageURL: String = ""
    var bookAuthor: String = ""
    var bookPublisher: String = ""
    var bookDate: String = ""
    var bookDes: String = ""
    var bookIsbn: String = ""

}

// MARK: - event 처리용 extension
extension ConfirmBookViewController {
    @objc func addToCell(_ selector: UIBarButtonItem) {
    if (self.bookTitle.isEmpty || self.bookAuthor.isEmpty) {
            self.view.makeToast("책 정보가 정확하지 않습니다.", duration: 2, position: .bottom)
            return
        }
        
        network.postRegisterBooks(title: self.bookTitle, img_url: self.bookImageURL, author: self.bookAuthor, pubilsher: self.bookPublisher, isbn: self.bookIsbn, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @objc func didTapShowAll(_ sender: UIButton) {
        self.showShortButton.isHidden = false
        sender.isHidden = true
        self.descriptionTextView.snp.remakeConstraints() { make in
            make.leading.trailing.equalToSuperview().inset(23)
            make.top.equalTo(label_summary.snp.bottom).offset(15)
            make.height.equalTo(self.descriptionTextView.intrinsicContentSize.height)
        }
        scrollView.contentLayoutGuide.snp.remakeConstraints() { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(self.scrollView.frame.height + self.descriptionTextView.frame.height + 30)
        }
    }
    
    @objc func didTapShowShort(_ sender: UIButton) {
        self.showallButton.isHidden = false
        sender.isHidden = true
        self.descriptionTextView.snp.remakeConstraints() { make in
            make.leading.trailing.equalToSuperview().inset(23)
            make.top.equalTo(label_summary.snp.bottom).offset(15)
            make.height.equalTo(100)
        }
        scrollView.contentLayoutGuide.snp.remakeConstraints() { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}


// MARK: - 레이아웃 용 extension
extension ConfirmBookViewController {
    // Set Up Functions
    func setUpView() {
        self.view.addSubview(scrollView)
        self.view.backgroundColor = .white
        scrollView.addSubview(contentView)
        contentView.addSubviews(layout_book, titleLabel, authorLabel, publisherLabel, descriptionTextView, showallButton, showShortButton, divideView, upperDivideView, label_summary)
        setNavCustom()
    }
    
    func setNavCustom() {
        self.setNavigationCustom(title: "")
        self.setNavigationLabelButton(title: "등록", action: #selector(addToCell))
    }
    
    func setConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.snp.makeConstraints() { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        scrollView.contentLayoutGuide.snp.makeConstraints() { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints() { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
        }
        
        upperDivideView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(5)
            make.top.equalTo(contentView.snp.top).offset(32)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        upperDivideView.layer.cornerRadius = 2
        upperDivideView.backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1)
        
        layout_book.snp.makeConstraints() { make in
            make.top.equalTo(upperDivideView.snp.bottom).offset(11)
            make.width.equalTo(222)
            make.height.equalTo(307)
            make.centerX.equalToSuperview()
        }
        layout_book.layer.borderWidth = 1
        layout_book.layer.borderColor = UIColor.clear.cgColor
        layout_book.backgroundColor = .lightGray
        layout_book.layer.cornerRadius = 6
        layout_book.layer.shadowColor = UIColor.darkGray.cgColor
        layout_book.layer.shadowRadius = 3
        layout_book.layer.shadowOffset = CGSize(width: 1, height: 3)
        layout_book.layer.masksToBounds = false
        layout_book.layer.shadowOpacity = 0.5
        layout_book.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .textLightGray
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(24)
        }
        titleLabel.text = "제목 정보가 없습니다."
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        authorLabel.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
        }
        authorLabel.text = "작가 정보가 없습니다."
        authorLabel.font = .boldSystemFont(ofSize: 15)
        authorLabel.textColor = UIColor(red: 113/256, green: 113/256, blue: 113/256, alpha: 1)
        authorLabel.textAlignment = .center
        
        publisherLabel.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.centerX.equalTo(authorLabel.snp.centerX)
            make.top.equalTo(authorLabel.snp.bottom).offset(8)
        }
        publisherLabel.text = "출판사 정보가 없습니다."
        publisherLabel.font = .systemFont(ofSize: 14)
        publisherLabel.textColor = UIColor(red: 113/256, green: 113/256, blue: 113/256, alpha: 1)
        publisherLabel.textAlignment = .center
        
        divideView.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(15)
            make.top.equalTo(publisherLabel.snp.bottom).offset(49)
        }
        divideView.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        label_summary.snp.makeConstraints() { make in
            make.top.equalTo(divideView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(23)
        }
        label_summary.sizeToFit()
        label_summary.numberOfLines = 0
        label_summary.setTxtAttribute("줄거리", size: 15, weight: .semibold, txtColor: .textBoldGray)
        
        descriptionTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(23)
            make.top.equalTo(label_summary.snp.bottom).offset(15)
            make.height.equalTo(100)
        }
        descriptionTextView.sizeToFit()
        descriptionTextView.setTxtAttribute("설명이 없습니다", size: 14, weight: .regular, txtColor: .black)
        descriptionTextView.textAlignment = .justified
        descriptionTextView.numberOfLines = 0
        
        showallButton.snp.makeConstraints { make in
            make.trailing.equalTo(descriptionTextView.snp.trailing)
            make.top.equalTo(descriptionTextView.snp.bottom).offset(7)
        }
        showallButton.setTitle("전체보기", size: 11, weight: .medium, color: .textGray)
        showallButton.addTarget(self, action: #selector(didTapShowAll), for: .touchUpInside)
        
        showShortButton.snp.makeConstraints() { make in
            make.trailing.equalTo(descriptionTextView.snp.trailing)
            make.top.equalTo(descriptionTextView.snp.bottom).offset(7)
        }
        showShortButton.setTitle("닫기", size: 11, weight: .medium, color: .textGray)
        showShortButton.addTarget(self, action: #selector(didTapShowShort), for: .touchUpInside)
        showShortButton.isHidden = true
    }
    
    func showContents() {
        titleLabel.text = self.bookTitle
        authorLabel.text = self.bookAuthor
        
        bookDate.insert(".", at: bookDate.index(bookDate.startIndex, offsetBy: 4))
        bookDate.insert(".", at: bookDate.index(bookDate.startIndex, offsetBy: 7))
        publisherLabel.text = "출판사  " + self.bookPublisher + "     발행일  " + bookDate
        
        descriptionTextView.text = self.bookDes
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: self.bookImageURL), placeholder: nil, options: [.transition(.fade(0.5)), .forceRefresh], completionHandler: nil)
        //imageView.setImageUrl(url: self.bookImageURL)
    }
}

// MARK: - 네트워크 용 extension
extension ConfirmBookViewController {
    func getBookSearchAPI() {
        network.getBookSearch(isbn: self.isbnValue) { response in
            switch response {
            case .success(let bookSearchData):
                if let data = bookSearchData as? BookSearch {
                    self.bookTitle = data.myData[0].title
                    self.bookImageURL = data.myData[0].image
                    self.bookAuthor = data.myData[0].author
                    self.bookPublisher = data.myData[0].publisher
                    self.bookDate = data.myData[0].pubdate
                    self.bookDes = data.myData[0].description
                    self.bookIsbn = data.myData[0].isbn
                    
                    self.showContents()
                }
            case .requestErr(let message):
                print("requestErr: \(message)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .decodeFail:
                print("decodeFail")
            }
        }
    }
}
