//
//  BookDetailViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/10.
//

import UIKit
import SnapKit
import Charts

// MARK: - 책 세부 내용 화면 뷰 컨트롤러
class BookDetailViewController: UIViewController {
    var layout_bookdetail = layout_BookDetail()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout_bookdetail.initViews(view: self.view)
    }

}

// MARK: - 책 세부 내용 화면 layout class
class layout_BookDetail {
    var layout_scroll = UIScrollView()
    
    var layout_main = UIView()
    var layout_horizontal = UIView()
    var layout_book = UIView()
    var img_book = UIImageView()
    
    var label_title = UILabel()
    var label_author = UILabel()
    
    var layout_vertical = UIView()
    var label_firstread = UILabel()
    var label_firstread_data = UILabel()
    
    var label_totaltime = UILabel()
    var label_totaltime_data = UILabel()
    
    var layout_line = UIView()
    var label_untilFin = UILabel()
    var label_untilFin_data = UILabel()
    
    var label_nowpage_data = UILabel()
    var label_totalpage_data = UILabel()
    
    var label_zero = UILabel()
    var label_hundred = UILabel()
    
    var btn_pageinput = UIView()
    var label_pageinput = UILabel()
    
    var label_myTime = UILabel()
    
    var label_summary = UILabel()
    var label_summary_data = UILabel()
    var btn_showall = UIButton()
    
    var layout_readingHBarGraph = HorizontalBarChartView()
    var layout_test = UIView()
    var chartEntry: [BarChartDataEntry] = []
    
    func initViews(view: UIView) {
        initViews_part1(view: view)
        initViews_part2(view: view)
    }
    
    func initViews_part1(view: UIView) {
        view.addSubview(layout_scroll)
        
        layout_scroll.translatesAutoresizingMaskIntoConstraints = false
        layout_scroll.snp.makeConstraints() { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        layout_scroll.frameLayoutGuide.snp.makeConstraints() { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        layout_scroll.addSubview(layout_main)
        layout_main.snp.makeConstraints() { make in
            make.edges.equalTo(layout_scroll.contentLayoutGuide)
            make.size.equalToSuperview()
        }
        
        layout_main.addSubviews(layout_horizontal, layout_book, label_title, label_author, layout_vertical, label_firstread, label_firstread_data, label_totaltime, label_totaltime_data)
        layout_horizontal.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(23)
            make.centerX.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(5)
        }
        layout_horizontal.layer.cornerRadius = 3
        layout_horizontal.clipsToBounds = false
        layout_horizontal.layer.borderColor = UIColor.black.cgColor
        layout_horizontal.backgroundColor = UIColor(Hex: 0xDFDFDF)
        
        layout_book.snp.makeConstraints() { make in
            make.top.equalToSuperview().offset(37)
            make.width.equalTo(170)
            make.height.equalTo(247)
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
        
        layout_book.addSubview(img_book)
        img_book.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
        img_book.layer.cornerRadius = 6
        img_book.clipsToBounds = true
        img_book.translatesAutoresizingMaskIntoConstraints = false
        img_book.contentMode = .scaleAspectFill
        img_book.image = UIImage(named: "book")
        
        label_title.snp.makeConstraints() { make in
            make.top.equalTo(layout_book.snp.bottom).offset(24)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
        }
        label_title.numberOfLines = 0
        label_title.textColor = .black
        label_title.text = "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목"
        label_title.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 600))
        label_title.textAlignment = .center
        
        label_author.snp.makeConstraints() { make in
            make.top.equalTo(label_title.snp.bottom).offset(10)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
        }
        label_author.textAlignment = .center
        label_author.textColor = .textBoldGray
        label_author.text = "무라세 다케시"
        label_author.font = .systemFont(ofSize: 20, weight: .semibold)
        
        layout_vertical.snp.makeConstraints() { make in
            make.top.equalTo(label_author.snp.bottom).offset(64)
            make.centerX.equalToSuperview()
            make.width.equalTo(2)
            make.height.equalTo(20)
        }
        layout_vertical.layer.cornerRadius = 3
        layout_vertical.clipsToBounds = false
        layout_vertical.layer.borderColor = UIColor.black.cgColor
        layout_vertical.backgroundColor = UIColor(Hex: 0xDFDFDF)
        
        label_firstread.snp.makeConstraints() { make in
            make.top.equalTo(label_author.snp.bottom).offset(50)
            make.trailing.equalTo(layout_vertical.snp.leading).offset(-61)
        }
        label_firstread.text = "처음 읽은 날"
        label_firstread.sizeToFit()
        label_firstread.textColor = .textBoldGray
        label_firstread.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        label_firstread_data.snp.makeConstraints() { make in
            make.centerX.equalTo(label_firstread)
            make.top.equalTo(label_firstread.snp.bottom).offset(10)
        }
        label_firstread_data.text = "2022.01.09"
        label_firstread_data.textColor = .black
        label_firstread_data.font = .systemFont(ofSize: 19, weight: .medium)
        
        label_totaltime.snp.makeConstraints() { make in
            make.leading.equalTo(layout_vertical.snp.trailing).offset(61)
            make.top.equalTo(label_firstread)
        }
        label_totaltime.text = "총 독서 시간"
        label_totaltime.sizeToFit()
        label_totaltime.textColor = .textBoldGray
        label_totaltime.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        label_totaltime_data.snp.makeConstraints() { make in
            make.centerX.equalTo(label_totaltime)
            make.top.equalTo(label_totaltime.snp.bottom).offset(10)
        }
        label_totaltime_data.text = "12:28.00"
        label_totaltime_data.textColor = .black
        label_totaltime_data.font = .systemFont(ofSize: 19, weight: .medium)
    }
    
    func initViews_part2(view: UIView) {
        layout_main.addSubviews(layout_line, label_untilFin, label_untilFin_data, label_nowpage_data, label_totalpage_data, label_zero, label_hundred, btn_pageinput, label_pageinput, label_myTime)
        
        layout_line.snp.makeConstraints() { make in
            make.top.equalTo(label_firstread.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.width.equalTo(344)
            make.height.equalTo(1)
        }
        layout_line.layer.cornerRadius = 3
        layout_line.clipsToBounds = false
        layout_line.layer.borderColor = UIColor.black.cgColor
        layout_line.backgroundColor = UIColor(Hex: 0xDFDFDF)
        
        label_untilFin.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.top.equalTo(layout_line.snp.bottom).offset(32)
        }
        label_untilFin.sizeToFit()
        label_untilFin.text = "완독까지"
        label_untilFin.textColor = .textLightGray
        label_untilFin.font = .systemFont(ofSize: 14, weight: .medium)
        
        label_untilFin_data.snp.makeConstraints() { make in
            make.leading.equalTo(label_untilFin.snp.trailing).offset(4)
            make.top.equalTo(label_untilFin)
        }
        label_untilFin_data.text = "42%"
        label_untilFin_data.textColor = .textOrange
        label_untilFin_data.sizeToFit()
        label_untilFin_data.font = .systemFont(ofSize: 14, weight: .medium)
        
        label_totalpage_data.snp.makeConstraints() { make in
            make.trailing.equalTo(layout_line.snp.trailing)
            make.top.equalTo(layout_line.snp.bottom).offset(28)
        }
        label_totalpage_data.text = "/ 354"
        label_totalpage_data.textColor = .textBoldGray
        label_totalpage_data.font = .systemFont(ofSize: 19, weight: .semibold)
        
        label_nowpage_data.snp.makeConstraints() { make in
            make.trailing.equalTo(label_totalpage_data.snp.leading).offset(-4)
            make.top.equalTo(label_totalpage_data)
        }
        label_nowpage_data.text = "120"
        label_nowpage_data.textColor = .textOrange
        label_nowpage_data.font = .systemFont(ofSize: 19, weight: .semibold)
        
        layout_main.addSubviews(layout_readingHBarGraph, label_zero, label_hundred)
        
//        layout_main.addSubview(layout_test)
//        layout_test.snp.makeConstraints() { make in
//            make.top.equalTo(label_untilFin.snp.bottom).offset(11)
//            make.leading.equalTo(label_untilFin)
//            make.trailing.equalTo(label_totalpage_data)
//            make.height.equalTo(15)
//        }
//        layout_test.backgroundColor = .textOrange
        
        layout_readingHBarGraph.snp.makeConstraints() { make in
            make.top.equalTo(label_untilFin.snp.bottom).offset(11)
            make.leading.equalTo(label_untilFin)
            make.trailing.equalTo(label_totalpage_data)
            make.height.equalTo(15)
        }
        layout_readingHBarGraph.layer.zPosition = 999
        setReadingBarAttribute()
        
        label_zero.snp.makeConstraints() { make in
            make.leading.equalTo(label_untilFin)
            make.top.equalTo(layout_readingHBarGraph.snp.bottom).offset(3)
        }
        label_zero.text = "0"
        label_zero.textColor = .textBoldGray
        label_zero.font = .systemFont(ofSize: 11, weight: .semibold)
        
        label_hundred.snp.makeConstraints() { make in
            make.trailing.equalTo(label_totalpage_data)
            make.top.equalTo(label_zero)
        }
        label_hundred.text = "100"
        label_hundred.textColor = .textBoldGray
        label_hundred.font = .systemFont(ofSize: 11, weight: .semibold)
    }
    
    func setReadingBarAttribute(data: Double = 45) {
        chartEntry.append(BarChartDataEntry(x: 1, y: 45))
        
        layout_readingHBarGraph.noDataText = "no data"
        layout_readingHBarGraph.doubleTapToZoomEnabled = false
        layout_readingHBarGraph.animate(xAxisDuration: 0, yAxisDuration: 5, easingOptionX: .linear, easingOptionY: .easeOutCirc)
        layout_readingHBarGraph.leftAxis.enabled = false
        layout_readingHBarGraph.rightAxis.enabled = false
        layout_readingHBarGraph.leftAxis.axisMaximum = 0
        layout_readingHBarGraph.legend.enabled = false
        layout_readingHBarGraph.xAxis.drawLabelsEnabled = false
        layout_readingHBarGraph.xAxis.drawGridLinesEnabled = false
        layout_readingHBarGraph.xAxis.drawAxisLineEnabled = false
        layout_readingHBarGraph.drawBarShadowEnabled = false
        
        let chartSet = BarChartDataSet(entries: chartEntry, label: "")
        chartSet.colors = [.lightOrange]
        chartSet.barShadowColor = .textLightGray
        chartSet.highlightEnabled = false
        chartSet.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: chartSet)
        layout_readingHBarGraph.data = data
    }
}
