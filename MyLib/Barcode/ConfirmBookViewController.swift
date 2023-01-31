//
//  ConfirmBookViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/07.
// Merge Again

import SnapKit

import UIKit

// MARK: - 책 확인 view controller
class ConfirmBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        self.view.backgroundColor = .systemBackground
        scrollView.addSubview(contentView)
        setUpContentView()
        setConstraints()
        setUpNavigationBar()
        getBookSearchAPI()
    }

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publisherLabel = UILabel()
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    let descriptionTextView = UILabel()
    let showallButton = UIButton()
    let contentView = UIView()
    let divideView = UIView()
    let upperDivideView = UIView()
    
    let network = Network()
    
    var bookTitle: String = ""
    var bookImageURL: String = ""
    var bookAuthor: String = ""
    var bookPublisher: String = ""
    var bookDate: String = ""
    var bookDes: String = ""
    var bookIsbn: String = ""

}

extension ConfirmBookViewController {
    // Set Up Functions
    func setUpView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    @objc func addToCell(_ selector: UIBarButtonItem) {
        // MARK: - todo: UIApplication에 데이터 저장할지 core data나 userDefaults 따로 쓸지
        if let appdel = UIApplication.shared.delegate as? AppDelegate {
            appdel.books.append([self.bookImageURL, self.bookTitle, self.bookAuthor])
        }
       
        network.registerBooks(title: self.bookTitle, img_url: self.bookImageURL, author: self.bookAuthor, pubilsher: self.bookPublisher, isbn: self.bookIsbn, completion: {
                self.navigationController?.popToRootViewController(animated: true)
        })
    }

}


// MARK: - 레이아웃 용 extension
extension ConfirmBookViewController {
    func setUpContentView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(publisherLabel)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(showallButton)
        contentView.addSubview(divideView)
        contentView.addSubview(upperDivideView)
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
        let btn = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(addToCell))
        btn.tintColor = .textOrange
        self.navigationItem.rightBarButtonItem = btn
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
        }
        scrollView.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        upperDivideView.snp.makeConstraints { make in
            make.width.equalTo(83)
            make.height.equalTo(4)
            make.top.equalTo(contentView.snp.top).offset(32)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        upperDivideView.layer.cornerRadius = 2
        upperDivideView.backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(222)
            make.height.equalTo(307)
            make.top.equalTo(upperDivideView.snp.bottom).offset(11)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
        }
        imageView.image = UIImage(named: "noBookImg")
        imageView.backgroundColor = .systemBlue
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = false
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.cornerRadius = 6
        
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
            make.top.equalTo(authorLabel.snp.bottom).offset(6)
        }
        publisherLabel.text = "출판사 정보가 없습니다."
        publisherLabel.font = .systemFont(ofSize: 14)
        publisherLabel.textColor = UIColor(red: 113/256, green: 113/256, blue: 113/256, alpha: 1)
        publisherLabel.textAlignment = .center
        
        descriptionTextView.snp.makeConstraints { make in
            make.width.equalTo(344)
            make.top.equalTo(publisherLabel.snp.bottom).offset(88)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        descriptionTextView.text = "설명이 없습니다."
        descriptionTextView.font = .systemFont(ofSize: 14)
        descriptionTextView.textColor = .black
        descriptionTextView.textAlignment = .justified
        descriptionTextView.numberOfLines = 4
        
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(670)
        }
        contentView.backgroundColor = .white
        
        divideView.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(15)
            make.top.equalTo(publisherLabel.snp.bottom).offset(49)
        }
        divideView.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        showallButton.snp.makeConstraints { make in
            make.trailing.equalTo(descriptionTextView.snp.trailing)
            make.top.equalTo(descriptionTextView.snp.bottom).offset(7)
            
        }
        showallButton.setTitle("전체 보기", for: .normal)
        
        showallButton.setTitleColor(.gray, for: .normal)
        showallButton.titleLabel?.font = .systemFont(ofSize: 11)

    }
    
    func showContents() {
        titleLabel.text = self.bookTitle
        authorLabel.text = self.bookAuthor
        
        bookDate.insert(".", at: bookDate.index(bookDate.startIndex, offsetBy: 4))
        bookDate.insert(".", at: bookDate.index(bookDate.startIndex, offsetBy: 7))
        publisherLabel.text = "출판사 " + self.bookPublisher + "     발행일 " + bookDate
        
        descriptionTextView.text = self.bookDes
        imageView.setImageUrl(url: self.bookImageURL)
    }
}

// MARK: - 네트워크 용 extension
extension ConfirmBookViewController {
    func getBookSearchAPI() {
        network.getBookSearch { response in
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
                    
//                    print(data.myData[0].title)
//                    print(self.bookTitle)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
