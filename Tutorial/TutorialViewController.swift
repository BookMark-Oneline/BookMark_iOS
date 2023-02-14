//
//  TutorialViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/15.
//

import UIKit
import SnapKit

// MARK: - 튜토리얼 view controller
class TutorialViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
         return vc
     }()
    
    let dataViewControllers: [UIViewController] = {
        return [FirstPageViewController(), SecondPageViewController(), ThirdPageViewController(), FourthPageViewController()]
    }()
    
    let button = UIButton()
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        setBaseView()
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setBaseView() {
        self.addChild(pageViewController)
        self.view.addSubviews(pageViewController.view, button, pageControl)
        self.view.backgroundColor = .white
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(227)
        }
        pageViewController.didMove(toParent: self)
        
        button.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(58)
        }
        button.layer.zPosition = 999
        button.layer.cornerRadius = 26
        button.backgroundColor = .lightOrange
        button.setTitle("시작하기", size: 17, weight: .bold, color: .white)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        
        pageControl.snp.makeConstraints() { make in
            make.bottom.equalTo(button.snp.top).offset(-31)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .lightOrange
        
    }
    
    @objc func didTapStartButton(_ sender: UIButton) {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let _ = pageViewController.viewControllers?[0] as? FirstPageViewController { pageControl.currentPage = 0 }
            else if let _ = pageViewController.viewControllers?[0] as? SecondPageViewController { pageControl.currentPage = 1 }
            else if let _ = pageViewController.viewControllers?[0] as? ThirdPageViewController { pageControl.currentPage = 2 }
            else if let _ = pageViewController.viewControllers?[0] as? FourthPageViewController { pageControl.currentPage = 3 }
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        var previousIndex = index - 1
        if previousIndex < 0 {
            previousIndex = 3
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        var nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            nextIndex = 0
        }
        return dataViewControllers[nextIndex]
    }
}
