//
//  CommunityTab.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//  Edited by BoMin on 2023/01/27.
//

import UIKit
import SnapKit
import Kingfisher

// MARK: - 책 모임 탭
class CommunityTab: UIViewController {
    
    let mainView = CommunityTabView()
    let collectView = Communities()
    
//MARK: - NetworkTintin
    let network = NetworkTintin()
    
    var communities = [[String]]()


    override func viewDidLoad() {
        super.viewDidLoad()
//        mainView.initViews(view: self.view)
        addTargets()
        mainView.collection.communities.delegate = self
        mainView.collection.communities.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        mainView.collection.communities.reloadData()
        dataReload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func addTargets() {
        mainView.searchButton.addTarget(self, action: #selector(searchButtonPress), for: .touchUpInside)
        mainView.addButton.addTarget(self, action: #selector(addButtonPress), for: .touchUpInside)
    }
    
//    func dataReload(status: Int = 1) {
//        // 데이터 새로 추가
//        if (status == 0) {
//            if let appdel = UIApplication.shared.delegate as? AppDelegate {
//                appdel.communities = self.communities
//            }
//            mainView.communityCount = self.communities.count
////            collectView.comCount = self.communities.count
//
//            mainView.initViews(view: self.view)
////            if (self.communities.count > 0) {
////                collectView.initView(view: mainView.collectView)
////            }
//        }
//        else {
//            self.communities = ((UIApplication.shared.delegate as? AppDelegate)?.communities)!
//        }
//        mainView.collection.communities.reloadData()
//    }
    
    func dataReload() {
        getCommunityListData(completion: {
            self.mainView.communityCount = self.communities.count
            self.mainView.initViews(view: self.view)
        })
    }
    
    @objc func searchButtonPress() {
        self.navigationController?.pushViewControllerTabHidden(SearchCommunityViewController(), animated: true)
    }

    @objc func addButtonPress() {
        let createCommunityVC = CreateCommunityViewController()
        self.navigationController?.pushViewControllerTabHidden(createCommunityVC, animated: true)
    }

}

extension CommunityTab {
    func getCommunityListData(completion: @escaping() -> Void) {
        network.getCommunityList { res in
            switch res {
            case .success(let communityList):
                if let com = communityList as? [CommunityList] {
                    self.communities.removeAll()
                    com.forEach({ item in
                        self.communities.append(["\(item.clubImgURL)", "\(item.clubName)"])
                        self.mainView.collection.communities.reloadData()
                    })
                }
                completion()
            case .serverErr:
                print("se")
            case .pathErr:
                print("pe")
            case .networkFail:
                print("nf")
            case .decodeFail:
                print("df")
            default:
                print("failed")
            }
        }
    }
}

extension CommunityTab: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.communities.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "communityCell", for: indexPath) as? CommunitiesCell else {
            return CommunitiesCell()
        }
        let community = self.communities[indexPath.row]
        
        cell.communityImageView.kf.indicatorType = .activity
        cell.communityImageView.kf.setImage(with: URL(string: community[0]), placeholder: nil, options: [.transition(.fade(1)), .cacheOriginalImage, .forceTransition], completionHandler: nil)
        cell.communityTitleLabel.text = community[1]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? CommunitiesCell else {
            return
        }
        self.navigationController?.pushViewControllerTabHidden(CommunityInsideViewController(), animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.collectView.bounds.width-46, height: 150)
    }
}

class CommunityTabView: UIView {
    var communityCount: Int = 0
    
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
        view.backgroundColor = .lightGray

        return view
    }()
    
    let searchButton: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: "search"), for: .normal)
        
        return btn
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: "add"), for: .normal)
        
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
        
        label.frame = CGRect(x: 0, y: 0, width: 227, height: 63)
        label.textColor = .black
        label.text = "모임을 생성하거나\n검색하여 다양한 사람들과\n소통해보세요"
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 3
        
        let attributedStr = NSMutableAttributedString(string: label.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.textOrange, range: (label.text! as NSString).range(of: "소통"))
        label.attributedText = attributedStr
        
        
        return label
    }()
    
    func initViews(view: UIView) {
        if (self.communityCount == 0) {
            view.addSubviews(titleView, descriptLabel)

            titleView.snp.makeConstraints() { make in
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.height.equalTo(44)
            }
            
            descriptLabel.snp.makeConstraints() { make in
                make.width.equalToSuperview().offset(-23)
                make.height.equalTo(95)
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(23)
                make.top.equalTo(titleView.snp.bottom).offset(43)
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
            
        } else {
            self.descriptLabel.removeFromSuperview()
            
            view.addSubview(titleView)
            
            view.addSubview(collectView)
        
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

            collection.initView(view: collectView, comCount: self.communityCount)
        }
    }
    
}

class Communities {
//    var comCount: Int = 0
    
    let myCommunityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "참여 중인 모임"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
                
        return label
    }()
    
    let communityCountLabel: UILabel = {
        let label = UILabel()
        
//        label.text = "5"
        label.textColor = .textGray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    let communities: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.register(CommunitiesCell.self, forCellWithReuseIdentifier: "communityCell")
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        
        return view
    }()
    
    func initView(view: UIView, comCount: Int) {
        view.addSubviews(myCommunityLabel, communityCountLabel, communities)
        
        myCommunityLabel.snp.makeConstraints() { make in
            make.leading.equalToSuperview().offset(23)
            make.top.equalToSuperview().offset(20)
        }
        
        communityCountLabel.snp.makeConstraints() { make in
            make.leading.equalTo(myCommunityLabel.snp.trailing).offset(5)
            make.centerY.equalTo(myCommunityLabel)
        }
        
        communityCountLabel.text = String(comCount)
        
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
        let img = UIImage(named: "right")
        
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
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(110)
        }
        
        communityDetailView.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(communityImageView.snp.bottom).offset(1)
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

