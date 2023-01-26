//
//  ReadingTime.swift
//  BookMark
//
//  Created by BoMin on 2023/01/11.
//
import UIKit
import SnapKit

class ReadingTime: UIViewController {
// MARK: - Network
    let network = Network()

// MARK: - Timer Components
    let timerView: UIView = {
        let view = UIView()

        view.frame = CGRect(x: 0, y: 0, width: 258, height: 258)
        view.layer.borderColor = UIColor.textOrange.cgColor
        view.layer.borderWidth = 10
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 129

        return view
    }()

    var timer: Timer = Timer()
    var timeCount: Int = 0
    var timerRunning: Bool = false
    var shouldPostTimerStart: Bool = true

    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00"
        label.textColor = .textGray
        // Font 수정?
//        label.font = UIFont(name: "SUIT-ExtraLight", size: 80)
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()

    let timerButton: UIButton = {
        let btn = UIButton()

        btn.frame = CGRect(x: 0, y: 0, width: 66, height: 66)
        btn.backgroundColor = .textOrange
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 33

        // 시작, 멈춤 버튼 이미지 파일 요청해야 함, 받기 전까지는 텍스트 대체
//        btn.setImage("timer-start.png", for: .normal)
//        btn.setImage("timer-stop.png", for: .selected)
        btn.setTitle("시작", for: .normal)
        btn.setTitle("멈춤", for: .selected)

        btn.addTarget(self, action: #selector(timerButtonAction), for: .touchUpInside)

        return btn
    }()

    let stopButton: UIButton = {
        let btn = UIButton()

        btn.frame = CGRect(x: 0, y: 0, width: 66, height: 66)
        btn.backgroundColor = .textOrange
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 33

        // 종료 버튼 이미지 파일 요청해야 함, 받기 전까지는 텍스트 대체
        btn.setTitle("종료", for: .normal)

        btn.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)

        return btn
    }()

// MARK: - History Components
    
    var timeHistories: [Int] = []

    let timeHistoryView: UIView = {
        let view = UIView()

        view.frame = CGRect(x: 0, y: 0, width: 390, height: 241)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 42.5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1).cgColor

        return view
    }()

// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayouts()
    }

}

extension ReadingTime {

// MARK: Button Action Functions
    @objc func timerButtonAction(_ sender: UIButton) {
// MARK: - TimerStart POST
        if (shouldPostTimerStart) {
            shouldPostTimerStart = false
            network.timerStart(completion: {
                print("---[POST] TIMER START---")
            })
        }
        if (timerRunning) {
            timerButton.isSelected = false
            timerRunning = false
            shouldPostTimerStart = false
            timer.invalidate()
        }
        else {
            timerButton.isSelected = true
            timerRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }

    @objc func stopButtonAction(_ sender: UIButton) {
        shouldPostTimerStart = true
        self.timeHistories.append(self.timeCount)
        print("--TIMER STOP--")
        print(self.timerLabel.text!)
        self.timeCount = 0
        self.timer.invalidate()
        self.timerLabel.text = "00 : 00"
        
// MARK: - TimerStop POST
        network.timerStop(completion: {
            print("---[POST] TIMER STOP---")
//            print("Histories : \(self.timeHistories)")
        })
    }

// MARK: - Timer Calculation
    @objc func timerCounter() -> Void {
        timeCount = timeCount + 1
        let time = secToHourMinSec(sec: timeCount)
        let timeString = timeToString(h: time.0, m: time.1, s: time.2)
        self.timerLabel.text = timeString
        print(timeCount)
    }

    func secToHourMinSec(sec: Int) -> (Int, Int, Int) {
        return ((sec/3600), ((sec%3600)/60), ((sec%3600)%60))
    }

    func timeToString(h: Int, m: Int, s: Int) -> String {
        var str = ""
        if h >= 1 {
            str += String(format: "%02d", h)
            str += " : "
            str += String(format: "%02d", m)
            str += " : "
            str += String(format: "%02d", s)
        }
        else {
            str += String(format: "%02d", m)
            str += " : "
            str += String(format: "%02d", s)
        }
        
        return str
    }

// MARK: - setLayouts()
    func setLayouts() {
//        view.addSubviews(timerView, timerButton, stopButton, timeHistoryView)
        
        // History View 뺀 버전
        view.addSubviews(timerView, timerButton, stopButton)

        timerView.snp.makeConstraints() { make in
            make.width.equalTo(258)
            make.height.equalTo(258)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.snp.centerY)
        }

        timerButton.snp.makeConstraints() { make in
            make.width.equalTo(66)
            make.height.equalTo(66)
            make.top.equalTo(self.view.snp.centerY).offset(20)
            make.leading.equalTo(self.view.snp.centerX).offset(30)
        }

        stopButton.snp.makeConstraints() { make in
            make.width.equalTo(66)
            make.height.equalTo(66)
            make.top.equalTo(self.view.snp.centerY).offset(20)
            make.trailing.equalTo(self.view.snp.centerX).offset(-30)
        }

//        timeHistoryView.snp.makeConstraints() { make in
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(241)
//
//        }

        timerView.addSubview(timerLabel)

        timerLabel.snp.makeConstraints() { make in
            make.width.equalTo(250)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }


    }
}
