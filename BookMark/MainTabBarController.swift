//
//  MainTabBarController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/08.
//

import UIKit
import Toast_Swift

// MARK: - 앱 메인 화면
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    let username: String = "김독서"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tabBar.tintColor = .white
        tabBar.tintColor = .textOrange
        tabBar.unselectedItemTintColor = .textBoldGray
        
        setViewController()
        toastWelcomeMsg()
    }
    
    private func toastWelcomeMsg() {
        self.view.makeToast("\(username)님 환영합니다!", duration: 1.5, point: CGPoint(x: (tabBar.frame.minX + tabBar.frame.maxX) / 2, y: tabBar.frame.minY - tabBar.frame.height - 70), title: nil, image: nil, completion: nil)
    }
    
    // 탭 뷰 컨트롤러 설정
    private func setViewController() {
        let first = UINavigationController(rootViewController: MyLibTab())
        let firstBarItem = UITabBarItem(title: "나의 서재", image: UIImage(named: "mylib_normal"), tag: 1)
        first.tabBarItem = firstBarItem
        first.tabBarItem.selectedImage = UIImage(named: "mylib_tab")
        
        let second = UINavigationController(rootViewController: CommunityTab())
        let secondBarItem = UITabBarItem(title: "책 모임", image: UIImage(named: "community_normal"), tag: 2)
        second.tabBarItem = secondBarItem
        second.tabBarItem.selectedImage = UIImage(named: "community_tab")
        
        let third = UINavigationController(rootViewController: OneLineTab())
        let thirdBarItem = UITabBarItem(title: "오늘 한줄", image: UIImage(named: "oneline_normal"), tag: 3)
        third.tabBarItem = thirdBarItem
        third.tabBarItem.selectedImage = UIImage(named: "oneline_tab")
        
        let fourth = ScrapTab()
        let fourthBarItem = UITabBarItem(title: "스크랩 북", image: UIImage(named: "scrap_normal"), tag: 4)
        fourth.tabBarItem = fourthBarItem
        fourth.tabBarItem.selectedImage = UIImage(named: "scrap_tab")
        
        let fifth = UINavigationController(rootViewController: MyPageTab())
        let fifthBarItem = UITabBarItem(title: "마이 페이지", image: UIImage(named: "mypage_normal"), tag: 5)
        fifth.tabBarItem = fifthBarItem
        fifth.tabBarItem.selectedImage = UIImage(named: "mypage_tab")
        
        self.viewControllers = [first, second, third, fourth, fifth]
        self.selectedIndex = 2
    }

}
