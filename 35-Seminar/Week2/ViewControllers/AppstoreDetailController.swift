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
    
    private let developerView = UIView()
    
    private let developerNameLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Viva Republica",
                                                  color: .systemBlue,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    private let developerTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "개발자",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }
    
    private let developerInfoArrowIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        $0.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let ratingAndReviewsView = UIView()
    
    private let ratingAndReviewsButton = UIButton().then {
        
        var config = UIButton.Configuration.plain()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "평가 및 리뷰",
                                                                        color: .black,
                                                                        font: UIFont.systemFont(ofSize: 22,
                                                                                                weight: .black)))
        // 이미지
        config.image = UIImage(systemName: "chevron.right")
        config.imagePadding = 2
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14,
                                                                                  weight: .heavy)
        config.baseForegroundColor = .gray
        // 상하좌우 패딩
        config.contentInsets = .zero
        
        $0.configuration = config
    }
    
    private let averageRatingLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "4.4",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 64, weight: .bold))
    }
    
    private let ratingAndReviewsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 4
    }
    
    private let ratingAndReviewsStarsView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let ratingAndReviewsStarsBackgroundView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let ratingAndReviewsStarsForegroundImageView = UIImageView().then {
        $0.image = UIImage(named: "stars_container")
        $0.contentMode = .scaleAspectFit
    }
    
    private let ratingAndReviewsCountLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "8.4만개의 평가",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 17, weight: .medium))
    }
    
    private let mostHelpfulReviewTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "가장 도움이 되는 리뷰",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .medium))
    }
    
    private let userReviewView = UIView()
    
    private let userReviewCell = UIView().then {
        $0.backgroundColor = .white
        
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowRadius = 6
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowOpacity = 0.4
        $0.layer.masksToBounds = false
        
        $0.layer.cornerRadius = 16
    }
    
    private let userReviewTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "35기 YB 최지석",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .medium))
    }
    
    private let userReviewStarsView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let userReviewStarsBackgroundView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let userReviewStarsForegroundImageView = UIImageView().then {
        $0.image = UIImage(named: "stars_container")
        $0.contentMode = .scaleAspectFit
    }
    
    private let userReviewDateAndNameLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "10월 18일 · INFP",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }
    
    private let userReviewLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .regular),
                                                  lineBreakMode: .byTruncatingTail,
                                                  lineBreakStrategy: .hangulWordPriority)
        $0.numberOfLines = 0
    }
    
    private let selfRatingAndReviewView = UIView()
    
    private let selfRatingAndReviewTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "탭하여 평가하기",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .regular))
    }
    
    private let selfRatingStarIconsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let selfRatingFirstStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingSecondStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingThirdStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingFourthStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingFifthStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let selfRatingButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 12
    }
    
    private let selfReviewWritingButton = UIButton().then {

        var config = UIButton.Configuration.filled()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "리뷰 작성",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .semibold)))
        // 이미지
        config.image = UIImage(systemName: "square.and.pencil")
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12,
                                                                                  weight: .semibold)
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = UIColor.Week2ColorSet.buttonBackgroundLightGray

        $0.configuration = config
        
        // 커스텀 코너 반경 설정
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    private let appSupportButton = UIButton().then {

        var config = UIButton.Configuration.filled()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "앱 지원",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .semibold)))
        // 이미지
        config.image = UIImage(systemName: "questionmark.circle")
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12,
                                                                                  weight: .semibold)
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = UIColor.Week2ColorSet.buttonBackgroundLightGray

        $0.configuration = config
        
        // 커스텀 코너 반경 설정
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
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
                    
                    // 개발자 정보 뷰
                    developerView.addSubViews(
                        developerNameLabel,
                        developerTitleInfoLabel,
                        developerInfoArrowIconImageView
                    ),
                    // 평가 및 리뷰 뷰
                    ratingAndReviewsView.addSubViews(
                        ratingAndReviewsButton,
                        averageRatingLabel,
                        ratingAndReviewsStackView.addArrangedSubViews(
                            ratingAndReviewsStarsView.addSubViews(
                                ratingAndReviewsStarsBackgroundView,
                                ratingAndReviewsStarsForegroundImageView
                            ),
                            ratingAndReviewsCountLabel
                        ),
                        mostHelpfulReviewTitleInfoLabel,
                        // 사용자 리뷰 셀
                        userReviewView.addSubViews(
                            userReviewCell.addSubViews(
                                userReviewTitleLabel,
                                userReviewStarsView.addSubViews(
                                    userReviewStarsBackgroundView,
                                    userReviewStarsForegroundImageView
                                ),
                                userReviewDateAndNameLabel,
                                userReviewLabel
                            )
                        )
                    ),
                    // 셀프 평가 뷰
                    selfRatingAndReviewView.addSubViews(
                        selfRatingAndReviewTitleInfoLabel,
                        selfRatingStarIconsStackView.addArrangedSubViews(
                            selfRatingFirstStarIconButton,
                            selfRatingSecondStarIconButton,
                            selfRatingThirdStarIconButton,
                            selfRatingFourthStarIconButton,
                            selfRatingFifthStarIconButton
                        ),
                        selfRatingButtonsStackView.addArrangedSubViews(
                            selfReviewWritingButton,
                            appSupportButton
                        )
                    )
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
        
        // MARK: 개발자 정보 뷰
        developerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.left.equalToSuperview().inset(20)
        }
        
        developerTitleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(developerNameLabel.snp.bottom).offset(3)
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        developerInfoArrowIconImageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        // MARK: 평가 및 리뷰 뷰
        ratingAndReviewsButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.left.equalToSuperview().inset(20)
        }
        
        averageRatingLabel.snp.makeConstraints {
            $0.top.equalTo(ratingAndReviewsButton.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(20)
        }
        
        ratingAndReviewsStackView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalTo(averageRatingLabel.snp.centerY)
        }
        
        ratingAndReviewsStarsView.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(24)
        }

        ratingAndReviewsStarsBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(4.4 / 5.0)
        }
        
        ratingAndReviewsStarsForegroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mostHelpfulReviewTitleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(averageRatingLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(20)
        }
        
        // MARK: 사용자 리뷰 셀
        userReviewView.snp.makeConstraints {
            $0.top.equalTo(mostHelpfulReviewTitleInfoLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        userReviewCell.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        userReviewTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(20)
        }
        
        userReviewStarsView.snp.makeConstraints {
            $0.top.equalTo(userReviewTitleLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(16)
        }
        
        userReviewStarsBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(5.0 / 5.0)
        }
        
        userReviewStarsForegroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        userReviewDateAndNameLabel.snp.makeConstraints {
            $0.left.equalTo(userReviewStarsView.snp.right).offset(6)
            $0.centerY.equalTo(userReviewStarsView.snp.centerY)
            $0.right.equalToSuperview().inset(20)
        }
        
        userReviewLabel.snp.makeConstraints {
            $0.top.equalTo(userReviewDateAndNameLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }
        
        // MARK: 사용자 본인 리뷰 및 평가 셀
        selfRatingAndReviewTitleInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        selfRatingStarIconsStackView.snp.makeConstraints {
            $0.top.equalTo(selfRatingAndReviewTitleInfoLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        selfRatingButtonsStackView.snp.makeConstraints {
            $0.top.equalTo(selfRatingStarIconsStackView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview()
        }
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
