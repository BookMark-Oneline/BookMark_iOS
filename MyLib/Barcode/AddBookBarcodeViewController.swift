//
//  AddBookBarcodeViewController.swift
//  BookMark
//
//  Created by BoMin on 2023/01/10.
//

import UIKit
import SnapKit

class AddBookBarcodeViewController: UIViewController {
// MARK: - ToDo - ReaderView 좌표...
    var readerView: BarcodeReaderView!
//    let readButton: UIButton = {
//        let btn = UIButton()
//
//        btn.frame = CGRect(x: 0, y: 0, width: 286, height: 50)
//        btn.backgroundColor = UIColor.textOrange
//        btn.titleLabel?.textColor = .white
//        btn.setTitle("스캔하기", for: .normal)
//        btn.setTitle("스캔을 멈추기", for: .selected)
//        btn.addTarget(self, action: #selector(scanButtonAction(_:)), for: .touchUpInside)
//        btn.layer.masksToBounds = true
//        btn.layer.cornerRadius = 15
//        return btn
//    }()
    
    let layout_main = UIView()
    let layout_redLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.readerView = BarcodeReaderView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY ?? 0.0), width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0.0) - 75))
        readerView.layer.masksToBounds = true
        
        self.readerView.delegate = self
        self.setNavigationCustom(title: "바코드 인식")
        if !self.readerView.isRunning {
            self.readerView.start()
        }
        setLayouts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }
}

extension AddBookBarcodeViewController {
//    @objc func scanButtonAction(_ sender: UIButton) {
//        if self.readerView.isRunning {
//            self.readerView.stop(isButtonTap: true)
//            readButton.isSelected = false
//        } else {
//            self.readerView.start()
//            readButton.isSelected = true
//        }
//    }
    
    func setLayouts() {
        self.view.backgroundColor = .white
        self.view.addSubviews(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
//        layout_main.addSubviews(readerView, readButton, layout_redLine)
        layout_main.addSubviews(readerView, layout_redLine)

        readerView.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
        
//        readButton.snp.makeConstraints() { make in
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().offset(168)
//        }
        
        layout_redLine.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(1)
        }
        layout_redLine.backgroundColor = UIColor(Hex: 0xFF0000)
    }
    
    func showConfirmBook(isbn: String) {
        let confirmView = ConfirmBookViewController()
        confirmView.isbnValue = isbn
        self.navigationController?.pushViewController(confirmView, animated: true)
    }
}

extension AddBookBarcodeViewController: BarcodeReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        let message = "바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        switch status {
        case let .success(code):
            guard let code = code else {
                self.view.makeToast(message, duration: 2, position: .bottom)
                break
            }
            showConfirmBook(isbn: code)
            
        case .fail:
            self.view.makeToast(message, duration: 2, position: .bottom)
//        case let .stop(isButtonTap):
//            if isButtonTap {
//                self.view.makeToast(message, duration: 2, position: .bottom)
//                self.readButton.isSelected = readerView.isRunning
//            } else {
//                self.readButton.isSelected = readerView.isRunning
//                return
//            }
        }
    }
}
