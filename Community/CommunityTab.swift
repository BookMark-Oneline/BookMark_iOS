//
//  CommunityTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//  Edited by BoMin on 2023/01/27.
//

import UIKit
import SnapKit

// MARK: - 책 모임 탭
class CommunityTab: UIViewController {
    
    let mainView = CommunityTabView()
    
    var communities = [
        ["myeongsoo", "책과 무스비"],
        ["haerin.jpg", "책마니+ 스터디와 함께하는 책읽기 프로젝트"],
        ["pepe.jpg", "밤에 책 읽는 애들"],
        ["haerin.jpg", "UMC2023 독서증진"],
        ["book", "책갈피 파이팅~"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.initViews(view: self.view)
        mainView.collection.communities.delegate = self
        mainView.collection.communities.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        mainView.collection.communities.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func loadCreateCommunity() {
        self.navigationController?.pushViewController(CreateCommunityViewController(), animated: true)
    }

}

extension CommunityTab: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.communities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "communityCell", for: indexPath) as? CommunitiesCell else {
            return CommunitiesCell()
        }
        let community = self.communities[indexPath.row]
        
        cell.communityImageView.image = UIImage(named: community[0])
        cell.communityTitleLabel.text = community[1]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? CommunitiesCell else {
            return
        }
        
        // community 진입
        print(item.communityTitleLabel.text ?? "default", "진입")
        
//        self.navigationController?.pushViewController(__책모임뷰컨트롤러이름__, animated: true)
        
    }
}

class CommunityTabView: UIView {
    let titleView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "책갈피 : 함께 한줄"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    let titleLine: UIView = {
        let view = UIView()

        view.frame = CGRect(x: 0, y: 0, width: 338, height: 1)
        view.backgroundColor = .semiLightGray

        return view
    }()
    
    let searchButton: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: "search"), for: .normal)
//        btn.addTarget(CommunityTabView.self, action: #selector(searchButtonPress), for: .touchUpInside)
        
        return btn
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: "add"), for: .normal)
        //btn.addTarget(self, action: #selector(addButtonPress), for: .touchUpInside)
        
        return btn
    }()
    
    let collectView: UIView = {
        let view = UIView()
        
        return view
    }()

    let collection: Communities = {
        let col = Communities()
        
        return col
    }()
    
    // myCommunityCount == 0 일 때만 보이게 하기
    let descriptLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
//    @objc func searchButtonPress() {
//        print("search button press")
//    }
//    
//    @objc func addButtonPress() {
//        print("add button press")
//    }
    
    func initViews(view: UIView) {
        view.addSubviews(titleView, collectView)
        
        titleView.snp.makeConstraints() { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        titleView.addSubviews(titleLabel, titleLine, searchButton, addButton)
        
        titleLabel.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(22)
        }
        
        titleLine.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(titleView)
            make.height.equalTo(1)
        }
                
        addButton.snp.makeConstraints() { make in
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        searchButton.snp.makeConstraints() { make in
            make.trailing.equalTo(addButton.snp.leading).offset(-23)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        collectView.snp.makeConstraints() { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom)
        }
        
        collection.initView(view: collectView)
    }
    
}

class Communities {
    let myCommunityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "참여 중인 모임"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
                
        return label
    }()
    
    let communityCountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "5"
        label.textColor = .textGray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    let communities: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 344, height: 150)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.register(CommunitiesCell.self, forCellWithReuseIdentifier: "communityCell")
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        
        return view
    }()
    
    func initView(view: UIView) {
        view.addSubviews(myCommunityLabel, communityCountLabel, communities)
        
        myCommunityLabel.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.top.equalToSuperview().offset(20)
        }
        
        communityCountLabel.snp.makeConstraints() { make in
            make.leading.equalTo(myCommunityLabel.snp.trailing).offset(5)
            make.centerY.equalTo(myCommunityLabel)
        }
        
        communities.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            make.top.equalTo(myCommunityLabel.snp.bottom).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

class CommunitiesCell: UICollectionViewCell {
    static let identifier = "communityCell"
    
    let communityImageView: UIImageView = {
        let view = UIImageView()

        view.backgroundColor = .lightLightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let communityDetailView: UIView = {
        let view = UIView()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(communityDetailPress))
        
        view.backgroundColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
//        view.addGestureRecognizer(tap)
//        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    let communityTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "책모임 이름"
        label.textColor = .white
        
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "right.png")
        
        view.image = img
        view.contentMode = .scaleAspectFill
        
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayouts()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func communityDetailPress() {
        print("community detail pressed")
    }
    
    func setLayouts() {
        addSubviews(communityImageView, communityDetailView)
        
        communityImageView.snp.makeConstraints() { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(344)
            make.height.equalTo(110)
        }
        
        communityDetailView.snp.makeConstraints() { make in
            make.leading.equalToSuperview()
            make.top.equalTo(communityImageView.snp.bottom).offset(1)
            make.width.equalTo(344)
            make.height.equalTo(40)
        }
        
        communityDetailView.addSubviews(communityTitleLabel, arrowImageView)
        
        communityTitleLabel.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(21)
        }
        
        arrowImageView.snp.makeConstraints() { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(6)
            make.height.equalTo(12)
        }
    }
}

