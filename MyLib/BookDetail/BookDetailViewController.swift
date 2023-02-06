//
//  BookDetailViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/10.
//

import UIKit
import SnapKit

// MARK: - 책 세부 내용 화면 뷰 컨트롤러
class BookDetailViewController: UIViewController {
    var layout_bookdetail = BookDetailView()
    var bookData: BookDetail?
    var isFavorite: Bool = false
    let pageInputPopUp = CustomPopUp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout_bookdetail.initViews(view: self.view)
        setNavCustom()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pageInput(_:)))
        layout_bookdetail.btn_pageinput.addGestureRecognizer(tapGestureRecognizer)
        pageInputPopUp.submitButton.addTarget(self, action: #selector(submitPopUp), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBookData()
    }
    
    // MARK: 책 세부 내용 데이터 바인딩
    func setBookData() {
        self.layout_bookdetail.label_title.text = bookData?.title
        self.layout_bookdetail.label_author.text = bookData?.author
        
        if let url = bookData?.img_url {
            self.layout_bookdetail.img_book.setImageUrl(url: url)
        }
        else {
            self.layout_bookdetail.img_book.image = UIImage(named: "noBookImg")
        }
        self.layout_bookdetail.label_totaltime_data.text = String(describing: bookData?.ave_reading_time ?? 0)
        self.layout_bookdetail.label_nowpage_data.text = String(describing: bookData?.ave_reading_page ?? 0)
        
        setProgress(readingPage: bookData?.ave_reading_page ?? 10, animated: false)
    }
    
    private func setProgress(readingPage: Int, totalPage: Int = 354, animated: Bool) {
        let progress = Int(Double(readingPage) / Double(totalPage) * 100)
        self.layout_bookdetail.label_untilFin_data.text = "\(progress)%"
        
        let percent = Float(Double(progress) / Double(100))
        self.layout_bookdetail.layout_progress.setProgress(percent, animated: animated)
    }
    
    // 페이지 입력
    @objc func pageInput(_ sender: UITapGestureRecognizer) {
        pageInputPopUp.allPageTextField.text = "354"
        pageInputPopUp.showPopUp(with: "책갈피",
                              message: "몇 페이지까지 읽으셨나요?",
                              on: self)
    }
    
    // 페이지 닫기
    @objc func submitPopUp() {
        // 페이지 수 전달
        UIView.animate(withDuration: 0.25,
                       animations: {
            self.pageInputPopUp.popUpView.frame = CGRect(x: 40,
                                                         y: self.view.frame.size.height,
                                                         width: self.view.frame.size.width-80,
                                                         height: 200)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.pageInputPopUp.backgroundView.alpha = 0
                }, completion: { done in
                    self.pageInputPopUp.popUpView.removeFromSuperview()
                    self.pageInputPopUp.backgroundView.removeFromSuperview()
                    
                    guard let page = self.pageInputPopUp.currentPageTextField.text else {return}
                    if (page.isEmpty) {return}
                    self.layout_bookdetail.label_nowpage_data.text = page
                    
                    self.setProgress(readingPage: Int(self.layout_bookdetail.label_nowpage_data.text ?? "0") ?? 10, animated: true)
                })
            }
        })
    }
}

// MARK: - 책 세부 내용 네비게이션 버튼 처리
extension BookDetailViewController {
    func setNavCustom() {
        self.setNavigationCustom(title: "")
        self.setNavigationImageButton(imageName: ["trash", "heart_black_unfill", "stopwatch"], action: [#selector(tapTrash), #selector(tapHeart), #selector(tapStopwatch)])
    }
    
    @objc func tapHeart(_ selector: UIBarButtonItem) {
        isFavorite.toggle()
        if (isFavorite) {
            selector.image = UIImage(named: "heart_black_fill")
        }
        else {
            selector.image = UIImage(named: "heart_black_unfill")
        }
    }
    
    @objc func tapStopwatch(_ selector: UIBarButtonItem) {
        self.navigationController?.pushViewController(ReadingTime(), animated: true)
        
    }
    
    @objc func tapTrash(_ selector: UIBarButtonItem) {
        let deletion = CustomAlertViewController()
        deletion.modalPresentationStyle = .overFullScreen
        deletion.cancelCompletion = { [weak self] in
            self?.deleteBookFromLib()
        }
        deletion.setAlertLabel(title: "책 삭제", subtitle: "읽던 책을 정말로 삭제하시겠습니까?")
        self.present(deletion, animated: true)
    }
    
    // MARK: - todo: 삭제 로직
    private func deleteBookFromLib() {
        print("delete tab")
    }
}
