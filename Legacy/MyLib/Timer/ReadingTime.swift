//
//  ReadingTime.swift
//  BookMark
//
//  Created by BoMin on 2023/01/11.
//
import UIKit
import SnapKit

class ReadingTime: UIViewController, UITableViewDelegate, UITableViewDataSource {
// MARK: - Network
    let network = Network()
    let networkT = NetworkTintin()
    let pageInputPopUp = CustomPopUp()
    var bookID: Int = 1
    var totalPage: Int = 0

    let stopwatchView = StopwatchView()
    
// MARK: - Timer Components
    let timerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 258, height: 258)
        
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

        btn.setImage(UIImage(named: "play"), for: .normal)
        btn.setImage(UIImage(named: "resume"), for: .selected)

        btn.addTarget(self, action: #selector(timerButtonAction), for: .touchUpInside)

        return btn
    }()

    let stopButton: UIButton = {
        let btn = UIButton()

        btn.frame = CGRect(x: 0, y: 0, width: 66, height: 66)
        btn.backgroundColor = .textOrange
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 33

        btn.setImage(UIImage(named: "stop"), for: .normal)
        btn.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)

        return btn
    }()
    
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
    
    let timeHistroyTable = Histories()

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayouts()
        setNav()
        timeHistroyTable.initView(view: timeHistoryView)
        timeHistroyTable.timeHistoryTableView.dataSource = self
        timeHistroyTable.timeHistoryTableView.delegate = self
        pageInputPopUp.submitButton.addTarget(self, action: #selector(submitPopUp), for: .touchUpInside)
    }
    
    // MARK: - setLayouts()
    func setLayouts() {
        view.addSubviews(timerView, timerButton, stopButton, timeHistoryView)

        timerView.snp.makeConstraints() { make in
            make.width.equalTo(258)
            make.height.equalTo(258)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.snp.centerY)
        }
        
        timerButton.snp.makeConstraints() { make in
            make.width.equalTo(66)
            make.height.equalTo(66)
            make.top.equalTo(timerView.snp.bottom).offset(-20)
            make.leading.equalTo(self.view.snp.centerX).offset(30)
        }

        stopButton.snp.makeConstraints() { make in
            make.width.equalTo(66)
            make.height.equalTo(66)
            make.top.equalTo(timerView.snp.bottom).offset(-20)
            make.trailing.equalTo(self.view.snp.centerX).offset(-30)
        }

        timeHistoryView.snp.makeConstraints() { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(timerButton.snp.bottom).offset(53)
            make.bottom.equalToSuperview()
        }
            
        stopwatchView.initViews(view: timerView)
        timerView.addSubview(timerLabel)

        timerLabel.snp.makeConstraints() { make in
            make.width.equalTo(250)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setNav() {
        self.navigationItem.title = "스톱워치"
    }
}

extension ReadingTime {
    // MARK: POST TIMER START 수정 필요
    func postTimerStartData() {
        network.postTimerStart(completion: {
            print("---[POST] TIMER START---")
        })
    }
    
    func postTimerStopData(curReadPage: Int) {
        let totalReadTime = 43
        
        networkT.postTimerStopFixed(bookID: self.bookID, userID: UserInfo.shared.userID, totalReadTime: timeCount, curReadPage: curReadPage, completion: { res in
            switch res {
            case .success:
                print("---[POST] TIMER STOP---")
            case .decodeFail:
                print("decode Fail")
            case .networkFail:
                print("network Fail")
            case .pathErr:
                print("path Err")
            case .serverErr:
                print("server Err")
            default:
                print("failed")
            }
        })
    }
}

extension ReadingTime {

// MARK: Button Action Functions
    @objc func timerButtonAction(_ sender: UIButton) {
// MARK: - TimerStart POST
        if (shouldPostTimerStart) {
            stopwatchView.circleAnimate()
            shouldPostTimerStart = false
            
            postTimerStartData()
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
        self.timeCount = 0
        self.timer.invalidate()
        self.timerLabel.text = "00 : 00"
        
//MARK: TotalPage
        pageInputPopUp.allPageTextField.text = String(self.totalPage)
        pageInputPopUp.showPopUp(with: "책갈피",
                              message: "몇 페이지까지 읽으셨나요?",
                              on: self)
    }
    
    @objc func submitPopUp(_ sender: UIButton) {
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
                    
                    self.postTimerStopData(curReadPage: Int(page) ?? -1)
                    
                })
            }
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
}

extension ReadingTime {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        // change
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DeleteAllCell.identifier, for: indexPath) as? DeleteAllCell else { return DeleteAllCell() }
            
            cell.selectionStyle = .none
            
            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TimeHistoryCell.identifier, for: indexPath) as? TimeHistoryCell else { return TimeHistoryCell() }
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else {
            return 50
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

class Histories {
    let timeHistoryTableView: UITableView = {
        let tbView = UITableView()
        tbView.backgroundColor = .white
        tbView.register(DeleteAllCell.self, forCellReuseIdentifier: DeleteAllCell
            .identifier)
        tbView.register(TimeHistoryCell.self, forCellReuseIdentifier: TimeHistoryCell.identifier)
        tbView.translatesAutoresizingMaskIntoConstraints = false
        return tbView
    }()
    
    func initView(view: UIView) {
        view.backgroundColor = .white
        view.addSubview(timeHistoryTableView)
        
        timeHistoryTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class DeleteAllCell: UITableViewCell {
    static let identifier = "DeleteAllCell"
    
    let deleteAllButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(deleteAllButton)
        
        deleteAllButton.snp.makeConstraints{ make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-25)
        }
        
        deleteAllButton.setImage(UIImage(named: "seeMore"), for: .normal)
        deleteAllButton.contentMode = .scaleAspectFit

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class TimeHistoryCell: UITableViewCell {
    static let identifier = "TimeHistoryCell"
    
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let deleteButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(dateLabel, timeLabel, deleteButton)
        
        dateLabel.snp.makeConstraints{ make in
            make.width.equalTo(100)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(23)
        }
        
        dateLabel.text = "23. 02. 05"
        dateLabel.font = .systemFont(ofSize: 18)
        dateLabel.textColor = .textGray
        
        timeLabel.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-54)
        }
        timeLabel.text = "2h 10m"
        timeLabel.font = .boldSystemFont(ofSize: 19)
        timeLabel.textAlignment = .right
        
        deleteButton.snp.makeConstraints{ make in
            make.width.equalTo(12.5)
            make.height.equalTo(12.5)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-25)
        }
        
        deleteButton.setImage(UIImage(named: "cancel"), for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
