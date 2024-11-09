//
//  AppstoreTabBarController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/7/24.
//

import UIKit

class AppstoreTabBarController: UITabBarController {
    
    deinit {
        debugPrint("TabBarController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (1) 탭바 아이템 리스트 생성
        let pages: [TabBarPage] = TabBarPage.allCases.sorted(by: { $0.pageIndex() < $1.pageIndex() })
        
        // (2) 탭바별 뷰 컨트롤러 생성 및 연결
        let viewControllers: [UINavigationController] = pages.map {
            createTabNavigationController(for: $0)
        }
        
        // (3) 탭바 스타일 지정 및 뷰 컨트롤러 연결
        configureTabBarController(with: viewControllers)
        
        // (4) 'app' 페이지를 초기 페이지로 지정
        selectPage(.app)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 탭 바 높이 변경
        setTabBarHeight()
    }
    
    
    // MARK: 주어진 페이지를 현재 페이지로 설정하는 메서드
    func selectPage(_ page: TabBarPage) {
        selectedIndex = page.pageIndex()
    }
    
    
    // MARK: 탭별 네비게이션 컨트롤러 및 뷰 컨트롤러 생성 메서드
    private func createTabNavigationController(for page: TabBarPage) -> UINavigationController {
        let viewController: UIViewController
        
        switch page {
        case .today:
            viewController = TodayHomeController()
        case .game:
            viewController = GameHomeController()
        case .app:
            viewController = AppstoreFinanceCategoryController()  // 3-4주차 과제
        case .arcade:
            viewController = ArcadeHomeController()
        case .server:
            viewController = ServerHomeController()
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem = UITabBarItem(
            title: page.pageName(),
            image: UIImage(systemName: page.iconName()),
            tag: page.pageIndex()
        )
        
        return navigationController
    }
    
    
    // MARK: 탭바 스타일 지정 및 초기화 메서드
    private func configureTabBarController(with navigationControllers: [UINavigationController]) {
        // TabBar의 ViewControllers 지정
        setViewControllers(navigationControllers, animated: false)
        
        // 탭바 아이콘 및 배경색 변경
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
    }
    
    
    // MARK: 탭바 높이 설정 메서드
    private func setTabBarHeight() {
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 90
        tabBarFrame.origin.y = view.frame.size.height - 90
        tabBar.frame = tabBarFrame
    }
}
