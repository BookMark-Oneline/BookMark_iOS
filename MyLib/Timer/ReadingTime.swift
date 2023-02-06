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

    let stopwatchView = StopwatchView()
    
// MARK: - Timer Components
    let timerView: UIView = {
        let view = UIView()

        view.frame = CGRect(x: 0, y: 0, width: 258, height: 258)
//        view.layer.borderColor = UIColor.textOrange.cgColor
//        view.layer.borderWidth = 10
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 129
        
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
        btn.setImage(UIImage(named: "play"), for: .normal)
        btn.setImage(UIImage(named: "resume"), for: .selected)
        //btn.setTitle("시작", for: .normal)
        //btn.setTitle("멈춤", for: .selected)

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
        btn.setImage(UIImage(named: "stop"), for: .normal)

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
        self.navigationItem.title = "스톱워치"
    }

}

extension ReadingTime {

// MARK: Button Action Functions
    @objc func timerButtonAction(_ sender: UIButton) {
// MARK: - TimerStart POST
        if (shouldPostTimerStart) {
            stopwatchView.circleAnimate()
            shouldPostTimerStart = false
            network.timerStart(completion: {
                print("---[POST] TIMER START---")
            })
        }
        if (timerRunning) {
            stopwatchView.pauseAnimation()
            timerButton.isSelected = false
            timerRunning = false
            shouldPostTimerStart = false
            timer.invalidate()
        }
        else {
            stopwatchView.resumeAnimation()
            timerButton.isSelected = true
            timerRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }

    @objc func stopButtonAction(_ sender: UIButton) {
        stopwatchView.stopAnimation()
        timerRunning = false
        timerButton.isSelected = false
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
        
        stopwatchView.initViews(view: timerView)

        timerView.addSubview(timerLabel)

        timerLabel.snp.makeConstraints() { make in
            make.width.equalTo(250)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }


    }
}

class StopwatchView: UIView {
    
    let shape = CAShapeLayer()
    
    let trackShape = CAShapeLayer()
    
    func initViews(view: UIView) {
        let circlePath = UIBezierPath(arcCenter: view.center,
                                      radius: 150,
                                      startAngle: .pi * (5/6),
                                      endAngle: .pi * (1/6),
                                      clockwise: true)
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 10
        trackShape.strokeColor = UIColor.lightGray.cgColor
        trackShape.lineCap = CAShapeLayerLineCap.round
        
        view.layer.addSublayer(trackShape)
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 10
        shape.strokeColor = UIColor.textOrange.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        shape.lineCap = CAShapeLayerLineCap.round
        
        view.layer.addSublayer(shape)
    }
    
    func circleAnimate() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        // 아래의 목표시간 현재 10초, 나중에 변경해야 함 (단위 : 초)
        animation.duration = 10
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.add(animation, forKey: "animation")
    }
    
    func pauseAnimation() {
        var pausedTime = shape.convertTime(CACurrentMediaTime(), from: nil)
        shape.speed = 0.0
        shape.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        var pausedTime = shape.timeOffset
        shape.speed = 1.0
        shape.timeOffset = 0.0
        shape.beginTime = 0.0
        let timeSincePause = shape.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shape.beginTime = timeSincePause
    }
    
    func stopAnimation() {
        shape.removeAllAnimations()
    }
}
