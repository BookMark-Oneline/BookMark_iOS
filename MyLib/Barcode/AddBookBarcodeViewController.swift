//
//  AddBookBarcodeViewController.swift
//  BookMark
//
//  Created by BoMin on 2023/01/10.
//

import UIKit
import SnapKit

class AddBookBarcodeViewController: UIViewController {
    var readerView: BarcodeReaderView!
    
    let layout_main = UIView()
    let layout_redLine = UIView()
    let label_txt = UILabel()
    
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
    func setLayouts() {
        self.view.backgroundColor = .white
        self.view.addSubviews(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        layout_main.addSubviews(readerView, layout_redLine, label_txt)

        readerView.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
        
        layout_redLine.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(1)
        }
        layout_redLine.backgroundColor = UIColor(Hex: 0xFF0000)
        
        label_txt.snp.makeConstraints() { make in
            make.top.equalTo(layout_redLine.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
        }
        label_txt.text = "책의 바코드를 인식해 주세요"
        label_txt.textColor = .white
        label_txt.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
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
            
        default:
            self.view.makeToast(message, duration: 2, position: .bottom)
        }
    }
}
