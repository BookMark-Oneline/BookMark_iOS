//
//  ConfirmBookViewController.swift
//  BookMark
//
//  Created by Jin younkyum on 2023/01/07.
//

import SnapKit

import UIKit

class ConfirmBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setUpContentView()
        setConstraints()
    }
    
    // MARK: - Views
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

}

extension ConfirmBookViewController {
    // Set Up Functions
    func setUpView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
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

    
    // Constraints
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
        titleLabel.text = "세상의 마지막 기차역에서"
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        authorLabel.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
        }
        authorLabel.text = "무라세 다케시"
        authorLabel.font = .boldSystemFont(ofSize: 15)
        authorLabel.textColor = UIColor(red: 113/256, green: 113/256, blue: 113/256, alpha: 1)
        authorLabel.textAlignment = .center
        
        publisherLabel.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.centerX.equalTo(authorLabel.snp.centerX)
            make.top.equalTo(authorLabel.snp.bottom).offset(6)
        }
        publisherLabel.text = "출판사 모모  발행일 2022.05.09"
        publisherLabel.font = .systemFont(ofSize: 14)
        publisherLabel.textColor = UIColor(red: 113/256, green: 113/256, blue: 113/256, alpha: 1)
        publisherLabel.textAlignment = .center
        
        descriptionTextView.snp.makeConstraints { make in
            make.width.equalTo(344)
            make.top.equalTo(publisherLabel.snp.bottom).offset(88)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        descriptionTextView.text = "봄이 시작되는 3월, 급행열차 한 대가 탈선해 절벽 아래로 떨어졌다. 수많은 중상자를 낸 이 대형 사고 때문에 유가족은 순식간에 사랑하는 가족, 연인을 잃었다. 그렇게 두 달이 흘렀을까. 사람들 사이에서 이상한 소문이 돌기 시작하는데…. 역에서 가장 가까운 역인 ‘니시유이가하마 역’에 가면 유령이 나타나 사고가 일어난 그날의 열차에 오르도록 도와준다는 것. 단 유령이 제시한 네 가지 규칙을 반드시 지켜야만 한다. 그렇지 않으면 자신도 죽게 된다. 이를 알고도 유가족은 한 치의 망설임도 없이 역으로 향한다. 과연 유령 열차가 완전히 하늘로 올라가 사라지기 전, 사람들은 무사히 열차에 올라 사랑하는 이의 마지막을 함께할 수 있을까. 틱톡에 소개되어 일본 독자들 사이에서 크게 입소문이 난 화제작. 현실과 판타지를 넘나들며 단숨에 독자를 이야기의 세계로 빠져들게 하는 무라세 다케시의 소설로, 작가의 여러 작품 중 한국에 처음 소개되는 작품이다. 작가가 쓴 작품 중 단연코 손꼽히는 판타지 휴머니즘 소설."
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
}

