//
//  AppstoreDetailController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/12/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class AppstoreDetailController: UIViewController {
    
    // AppDetailProduct 모델
    private var adpData = CurrentValueSubject<ADPData?, Never>(nil)
    
    private var cancellableBag = Set<AnyCancellable>()
    
    
    private let containerScrollView = UIScrollView()
    
    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    
    private let appTitleInfoView = AppTitleInfoView()
    
    private let appShortInfoSwipeView = AppShortInfoSwipeView()
    
    private let appNewUpdatesView = AppNewUpdatesView()
    
    private let appPreviewsView = AppPreviewsView()
    
    private let appCompatibleDevicesView = AppCompatibleDevicesView()
    
    private let appDetailInfoView = AppDetailInfoView()
    
    private let appDeveloperView = AppDeveloperView()
    
    private let appRatingAndReviewsView = AppRatingAndReviewsView()
    
    private let appSelfRatingAndReviewView = AppSelfRatingAndReviewView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindUI()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMockData()
    }
    
    deinit {
        print("Detail ViewController Deinit")
    }
    
    
    private func makeUI() {
        view.backgroundColor = .white
        
        // 탑 네비게이션
        setupNavigationItems()
        
        view.addSubViews(
            containerScrollView.addSubViews(
                containerStackView.addArrangedSubViews(
                    // 앱 타이틀 정보 뷰
                    appTitleInfoView,
                    // 앱 정보 수평 스크롤 뷰
                    appShortInfoSwipeView,
                    // 앱 새로운 소식 뷰
                    appNewUpdatesView,
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
        
        // 하위 뷰 하단 패딩 세팅
        containerStackView.setCustomSpacing(20, after: appTitleInfoView)
        containerStackView.setCustomSpacing(10, after: appShortInfoSwipeView)
        containerStackView.setCustomSpacing(24, after: appNewUpdatesView)
        containerStackView.setCustomSpacing(12, after: appPreviewsView)
        containerStackView.setCustomSpacing(20, after: appCompatibleDevicesView)
        containerStackView.setCustomSpacing(28, after: appDetailInfoView)
        containerStackView.setCustomSpacing(32, after: appDeveloperView)
        containerStackView.setCustomSpacing(20, after: appSelfRatingAndReviewView)
    }
    
    
    // 탑 네비게이션 세팅
    private func setupNavigationItems() {
        // 중앙 아이콘 버튼
        let iconButton = UIButton().then {
            let image = UIImage(named: "toss_icon") // 여기에 원하는 이미지 설정
            $0.setImage(image, for: .normal)
            $0.setImage(image, for: .highlighted)
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.Week2ColorSet.borderGray.cgColor
        }
        
        iconButton.snp.makeConstraints {
            $0.size.equalTo(26)
        }
        
        iconButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            let topSafeAreaHeight = view.safeAreaInsets.top
            containerScrollView.setContentOffset(CGPoint(x: 0, y: -topSafeAreaHeight), animated: true)
        }, for: .touchUpInside)
        
        navigationItem.titleView = iconButton
        navigationItem.titleView?.isHidden = true
        
        
        // 우측 '열기' 버튼
        let downloadButton = UIButton().then {
            $0.backgroundColor = UIColor.Week2ColorSet.primaryBlue
            $0.setAttributedTitle(.makeAttributedString(text: "열기",
                                                        color: .white,
                                                        font: UIFont.systemFont(ofSize: 15, weight: .semibold)),
                                  for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }
        
        downloadButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: downloadButton)
        navigationItem.rightBarButtonItem?.isHidden = true
    }
    
    
    private func bindUI() {
        adpData.sink(receiveValue: { [weak self] data in
            guard let self,
                  let data else { return }
            
            // (1) 앱 타이틀
            if let appTitleInfo = data.appTitleInfo {
                appTitleInfoView.setUI(with: appTitleInfo)
                appTitleInfoView.isHidden = false
            } else {
                appTitleInfoView.isHidden = true
            }
            
            // (2) 앱 요약 정보
            if let appShortInfo = data.appShortInfo {
                appShortInfoSwipeView.setUI(with: appShortInfo)
                appShortInfoSwipeView.isHidden = false
            } else {
                appShortInfoSwipeView.isHidden = true
            }
            
            // (3) 앱 새로운 소식
            if let appUpdates = data.appUpdates {
                appNewUpdatesView.setUI(with: appUpdates )
                appNewUpdatesView.isHidden = false
            } else {
                appNewUpdatesView.isHidden = true
            }
            
            // (4) 프리뷰 이미지
            if let previewImages = data.previewImages {
                appPreviewsView.setUI(with: previewImages)
                appPreviewsView.isHidden = false
            } else {
                appPreviewsView.isHidden = true
            }
            
            // (5) 호환 기기a
            if let compatibleDevices = data.compatibleDevices {
                appCompatibleDevicesView.setUI(with: compatibleDevices)
                appCompatibleDevicesView.isHidden = false
            } else {
                appCompatibleDevicesView.isHidden = true
            }
            
            // (6) 앱 디테일 정보
            if let appDetailInfo = data.appDetailInfo {
                appDetailInfoView.setUI(with: appDetailInfo)
                appDetailInfoView.isHidden = false
            } else {
                appDetailInfoView.isHidden = true
            }
            
            // (7) 개발자 정보
            if let developerInfo = data.developerInfo {
                appDeveloperView.setUI(with: developerInfo)
                appDeveloperView.isHidden = false
            } else {
                appDeveloperView.isHidden = true
            }
            
            // (8) 평점 및 사용자 리뷰
            if let ratingAndReviews = data.ratingAndReviews {
                appRatingAndReviewsView.setUI(with: ratingAndReviews)
                appRatingAndReviewsView.isHidden = false
            } else {
                appRatingAndReviewsView.isHidden = true
            }
        }).store(in: &cancellableBag)
    }
    
    
    private func setDelegates() {
        containerScrollView.delegate = self
        appNewUpdatesView.delegate = self
        appRatingAndReviewsView.delegate = self
        appSelfRatingAndReviewView.delegate = self
    }
    
    
    // 가짜 MockData fetch
    private func fetchMockData() {
        // json 파일 경로
        guard let url = Bundle.main.url(forResource: "adp_mock", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        // json 파일 디코딩
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ADPData.self, from: data)
            
            print(adpData)
            
            // 데이터 세팅
            adpData.send(decodedData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}


// MARK: - extensions

extension AppstoreDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// 최초 세팅 시 스크롤하지 않아도 해당 메서드가 호출되는데, 이때 appTitleInfoView의 frame이 0이기 때문에
        /// 아래 로직을 통해 navigationItem이 노출되는 이슈 존재
        /// 이를 방지하기 위해 appTitleInfo의 frame이 잡혔을 때만 해당 로직을 타도록 수정
        if appTitleInfoView.frame.height != 0 {
            let topSafeAreaHeight = view.safeAreaInsets.top
            
            /// 앱 타이틀 영역 '열기' 버튼 상단보다 스크롤 포지션이 아래에 위치하는 경우,
            /// 내비게이션 아이템을 보여주고, 앱 타이틀 영역 UI는 숨김 처리
            if scrollView.contentOffset.y + topSafeAreaHeight < appTitleInfoView.frame.maxY - 32 {
                showNavigationItems(false)
                appTitleInfoView.showInnerSubviews(true)
            } else {
                showNavigationItems(true)
                appTitleInfoView.showInnerSubviews(false)
            }
        }
    }
    
    
    private func showNavigationItems(_ shouldShowNavigationItems: Bool) {
        navigationItem.titleView?.isHidden = !shouldShowNavigationItems
        navigationItem.rightBarButtonItem?.isHidden = !shouldShowNavigationItems
    }
}


extension AppstoreDetailController: AppNewUpdatesViewDelegate {
    func newUpdatesButtonDidTap() {
        let appstoreVersionHistoryController = AppstoreVersionHistoryController()
        navigationController?.pushViewController(appstoreVersionHistoryController, animated: true)
        navigationItem.backButtonTitle = "뒤로"
    }
}


extension AppstoreDetailController: AppRatingAndReviewsViewDelegate {
    func ratingAndReviewsButtonDidTap() {
        let appstoreRatingAndReviewsController = AppstoreRatingAndReviewsController()
        navigationController?.pushViewController(appstoreRatingAndReviewsController, animated: true)
        navigationItem.backButtonTitle = "뒤로"
    }
}


extension AppstoreDetailController: AppSelfRatingAndReviewViewDelegate {
    func didReceiveUserRating(rating: Int) {
        print("별점: \(rating)")
        FeedBackDialog.shared.show()
    }
}


// MARK: - preview

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
