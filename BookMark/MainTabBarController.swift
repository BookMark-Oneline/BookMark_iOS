//
//  MainTabBarController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit

// MARK: - 앱 메인 화면
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tabBar.tintColor = .white
        tabBar.tintColor = .textOrange
        tabBar.unselectedItemTintColor = .textBoldGray
        
        setViewController()
    }
    
    // 탭 뷰 컨트롤러 설정
    private func setViewController() {
        let first = UINavigationController(rootViewController: MyLibTab())
        //let first = MyLibTab()
        let firstBarItem = UITabBarItem(title: "나의 서재", image: UIImage(named: "mylib_normal"), tag: 1)
        first.tabBarItem = firstBarItem
        first.tabBarItem.selectedImage = UIImage(named: "mylib_tab")
        
        let second = CommunityTab()
        let secondBarItem = UITabBarItem(title: "책 모임", image: UIImage(named: "community_normal"), tag: 2)
        second.tabBarItem = secondBarItem
        second.tabBarItem.selectedImage = UIImage(named: "community_tab")
        
        let third = OneLineTab()
        let thirdBarItem = UITabBarItem(title: "오늘 한줄", image: UIImage(named: "oneline_normal"), tag: 3)
        third.tabBarItem = thirdBarItem
        third.tabBarItem.selectedImage = UIImage(named: "oneline_tab")
        
        let fourth = ScrapTab()
        let fourthBarItem = UITabBarItem(title: "스크랩 북", image: UIImage(named: "scrap_normal"), tag: 4)
        fourth.tabBarItem = fourthBarItem
        fourth.tabBarItem.selectedImage = UIImage(named: "scrap_tab")
        
        let fifth = MyPageTab()
        let fifthBarItem = UITabBarItem(title: "마이 페이지", image: UIImage(named: "mypage_normal"), tag: 5)
        fifth.tabBarItem = fifthBarItem
        fifth.tabBarItem.selectedImage = UIImage(named: "mypage_tab")
        
        self.viewControllers = [first, second, third, fourth, fifth]
    }

}
