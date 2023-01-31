//
//  AddBookBarcode.swift
//  BookMark
//
//  Created by BoMin on 2023/01/10.
//

import UIKit
import SnapKit

class AddBookBarcode: UIViewController {
    
//    let network = Network()

    let readerView: BarcodeReaderView = {
        let view = BarcodeReaderView(frame: CGRect(x: 0, y: 0, width: 286, height: 137))
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    
    // 스캔 시작/스탑 버튼, 디자인적으로 문제가 된다면 없애고 코드 수정하도록 하겠음.
    let readButton: UIButton = {
        let btn = UIButton()
        
        btn.frame = CGRect(x: 0, y: 0, width: 286, height: 50)
        btn.backgroundColor = UIColor.textOrange
        btn.titleLabel?.textColor = .white
        btn.setTitle("스캔하기", for: .normal)
        btn.setTitle("스캔을 멈추기", for: .selected)
        btn.addTarget(self, action: #selector(scanButtonAction(_:)), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    let layout_main = UIView()
    let layout_redLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()

        self.view.backgroundColor = .systemBackground
        self.readerView.delegate = self

        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "바코드 인식"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }
}

extension AddBookBarcode {
    @objc func scanButtonAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(ConfirmBookViewController(), animated: true)
//
//        if self.readerView.isRunning {
//            self.readerView.stop(isButtonTap: true)
//        } else {
//            self.readerView.start()
//        }
//
//        sender.isSelected = self.readerView.isRunning
        
// MARK: - [GET] 책 검색
//        network.getBookSearch { response in
//            switch response {
//            case .success(let bookSearchData):
//                if let data = bookSearchData as? BookSearch {
////                    print(data.myData[0].title)
//                }
//            case .requestErr(let message):
//                print("requestErr", message)
//            case .pathErr:
//                print("pathErr")
//            case .serverErr:
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            }
//        }
        
    }
    
    func setLayouts() {
        self.view.addSubviews(layout_main, readerView, readButton, layout_redLine)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        layout_main.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        readerView.snp.makeConstraints() { make in
            make.width.equalTo(286)
            make.height.equalTo(137)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        readButton.snp.makeConstraints() { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp.centerY).offset(100)
        }
        
        layout_redLine.snp.makeConstraints() { make in
            make.width.equalTo(286)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        layout_redLine.backgroundColor = UIColor(Hex: 0xFF0000)
    }
    
    func showConfirmBook() {
        let confirmView = ConfirmBookViewController()
//        confirmView.modalPresentationStyle = .fullScreen
        // self.present(confirmView, animated: true, completion: nil)
        self.navigationController?.pushViewController(confirmView, animated: true)
    }
}

extension AddBookBarcode: BarcodeReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {

        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }

            title = "알림"
            message = "인식성공\n\(code)"
            
            // 책 등록 확인 뷰 전환
            showConfirmBook()
            
        case .fail:
            title = "에러"
            message = "바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                self.readButton.isSelected = readerView.isRunning
            } else {
                self.readButton.isSelected = readerView.isRunning
                return
            }
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
