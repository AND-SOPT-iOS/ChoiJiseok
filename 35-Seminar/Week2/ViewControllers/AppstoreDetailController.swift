//
//  AppstoreDetailController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/12/24.
//

import UIKit
import SnapKit
import Then

final class AppstoreDetailController: UIViewController {
    
    private let containerScrollView = UIScrollView()
    
    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    
    private let appTitleInfoView = AppTitleInfoView()
    
    private let appShortInfoSwipeView = AppShortInfoSwipeView()
    
    private let appNewUpdateView = AppNewUpdateView()
    
    private let appPreviewsView = AppPreviewsView()
    
    private let appCompatibleDevicesView = AppCompatibleDevicesView()
    
    private let appDetailInfoView = AppDetailInfoView()
    
    private let appDeveloperView = AppDeveloperView()
    
    private let appRatingAndReviewsView = AppRatingAndReviewsView()
    
    private let appSelfRatingAndReviewView = AppSelfRatingAndReviewView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    deinit {
        print("Detail ViewController Deinit")
    }
    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubViews(
            containerScrollView.addSubViews(
                containerStackView.addArrangedSubViews(
                    // 앱 타이틀 정보 뷰
                    appTitleInfoView,
                    // 앱 정보 수평 스크롤 뷰
                    appShortInfoSwipeView,
                    // 앱 새로운 소식 뷰
                    appNewUpdateView,
                    // 앱 프리뷰 이미지 리스트 뷰
                    appPreviewsView,
                    // 앱 호환 기기 뷰
                    appCompatibleDevicesView,
                    // 앱 디테일 정보 뷰
                    appDetailInfoView,
                    // 앱 개발자 정보 뷰
                    appDeveloperView,
                    // 평가 및 리뷰 뷰
                    appRatingAndReviewsView,
                    // 셀프 평가 뷰
                    appSelfRatingAndReviewView
                )
            )
        )
        
        containerScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        containerStackView.setCustomSpacing(20, after: appTitleInfoView)
        containerStackView.setCustomSpacing(10, after: appShortInfoSwipeView)
        containerStackView.setCustomSpacing(24, after: appNewUpdateView)
        containerStackView.setCustomSpacing(12, after: appPreviewsView)
        containerStackView.setCustomSpacing(20, after: appCompatibleDevicesView)
        containerStackView.setCustomSpacing(28, after: appDetailInfoView)
        containerStackView.setCustomSpacing(32, after: appDeveloperView)
        containerStackView.setCustomSpacing(20, after: appSelfRatingAndReviewView)
    }
    
    
    private func loadData() {
        // json 파일 경로
        guard let url = Bundle.main.url(forResource: "adp_mock", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        // json 파일 디코딩
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let adpData = try decoder.decode(ADPData.self, from: data)
            
            print(adpData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}


// SwiftUI preview
#if DEBUG
import SwiftUI
struct AppstoreDetailControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        AppstoreDetailController()
    }
}

#Preview {
    AppstoreDetailControllerRepresentable()
}
#endif
