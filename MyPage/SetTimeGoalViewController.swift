//
//  SetTimeGoalViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/07.
//

import UIKit
import SnapKit
import Toast_Swift

// MARK: - 목표 독서 시간 설정 view controller
class SetTimeGoalViewController: UIViewController {
    let timeGoalView = SetTimeGoalView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        timeGoalView.initViews(self.view)
        self.setNavigationCustom(title: "목표 독서 시간 설정")
        timeGoalView.btn_update.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        timeGoalView.btn_ok.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
    }
    
    @objc func didTapUpdateButton(_ sender: UIButton) {
        self.timeGoalView.label_nowGoal.isHidden = true
        self.timeGoalView.timePicker.isHidden = false
        self.timeGoalView.btn_ok.isHidden = false
        sender.isHidden = true
    }
    
    @objc func didTapOkButton(_ sender: UIButton) {
        self.timeGoalView.timePicker.isHidden = true
        let formatter = DateFormatter()
        formatter.dateFormat = "HH시간 mm분"
        let time = formatter.string(from: self.timeGoalView.timePicker.date)
        self.timeGoalView.label_nowGoal.text = "현재 목표 시간 : " + time
        self.timeGoalView.label_nowGoal.isHidden = false
        self.timeGoalView.btn_update.isHidden = false
        sender.isHidden = true
        
        UserDefaults.standard.set(time, forKey: "timeGoal")
        UserDefaults.standard.synchronize()
        
        self.view.makeToast("변경되었습니다", duration: 2, position: .bottom)
    }
}

// MARK: - 목표 독서 시간 설정 view
class SetTimeGoalView {
    var time: String = "0시간 0분"
    let layout_main = UIView()
    let line = UIView()
    let label_title = UILabel()
    let label_subtitle = UILabel()
    let timePicker = UIDatePicker()
    let label_nowGoal = UILabel()
    let btn_update = UIButton()
    let btn_ok = UIButton()
    
    func initViews(_ superView: UIView) {
        superView.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(superView.safeAreaLayoutGuide)
        }
        
        layout_main.addSubviews(line, label_title, label_subtitle, timePicker, label_nowGoal, btn_update, btn_ok)
        line.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        line.backgroundColor = .lightGray
        
        label_title.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(30)
        }
        label_title.sizeToFit()
        label_title.numberOfLines = 0
        label_title.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        let str = NSMutableAttributedString(string: "목표 독서 시간을\n설정하세요")
        str.addAttribute(.foregroundColor, value: UIColor.textOrange, range: NSRange(location: 3, length: 5))
        label_title.attributedText = str
        
        label_subtitle.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        label_subtitle.numberOfLines = 0
        label_subtitle.sizeToFit()
        label_subtitle.text = "목표 독서 시간은 나의 서재에 있는 모든 책에 공유됩니다."
        label_subtitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label_subtitle.textColor = .textLightGray
        
        timePicker.snp.makeConstraints() { make in
            make.top.equalTo(label_subtitle.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        timePicker.isHidden = true
        timePicker.datePickerMode = .countDownTimer
        timePicker.minuteInterval = 15
        
        label_nowGoal.snp.makeConstraints() { make in
            make.top.equalTo(label_subtitle.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        if let goal = UserDefaults.standard.string(forKey: "timeGoal") {
            self.time = goal
        }
        label_nowGoal.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label_nowGoal.text = "현재 목표 독서 시간 : " + self.time
        
        btn_update.snp.makeConstraints() { make in
            make.top.equalTo(label_nowGoal.snp.bottom).offset(50)
            make.width.equalTo(160)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        btn_update.backgroundColor = .lightOrange
        btn_update.layer.cornerRadius = 25
        btn_update.setTitle("수정하기", size: 17, weight: .bold, color: .white)
        
        btn_ok.snp.makeConstraints() { make in
            make.top.equalTo(timePicker.snp.bottom).offset(50)
            make.width.equalTo(160)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        btn_ok.isHidden = true
        btn_ok.backgroundColor = .lightOrange
        btn_ok.layer.cornerRadius = 25
        btn_ok.setTitle("완료", size: 17, weight: .bold, color: .white)
    }
}
