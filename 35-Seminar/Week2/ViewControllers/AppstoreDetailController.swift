//
//  AppstoreDetailController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/12/24.
//

import Foundation
import UIKit
import SnapKit
import Then

final class AppstoreDetailController: UIViewController {
    
    private let containerScrollView = UIScrollView()
    
    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let titleInfoView = UIView()
    
    private let titleLabelContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    private let appIconImageView = UIImageView().then {
        $0.image = UIImage(named: "toss_icon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Week2ColorSet.logoImageBorderColor.cgColor
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "토스",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    }
    
    private let descriptionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "금융이 쉬워진다.",
                                                  color: .lightGray,
                                                  font: UIFont.systemFont(ofSize: 15, weight: .medium))
    }
    
    private let downloadButton = UIButton().then {
        $0.backgroundColor = UIColor.Week2ColorSet.primaryBlue
        $0.setTitle("열기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setAttributedTitle(.makeAttributedString(text: "열기",
                                                    color: .white,
                                                    font: UIFont.systemFont(ofSize: 15, weight: .semibold)),
                              for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 14
    }
    
    private let shareIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let appInfoHorizontalSwipeContainerView = UIView()
    
    private let appInfoHorizontalSwipeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.addTopBorder(color: .lightGray, width: 1)
        $0.addBottomBorder(color: .lightGray, width: 1)
    }
    
    private let ratingView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
        $0.addRightBorder(color: .lightGray, width: 1, multiplier: 0.4)
    }
    
    private let ratingCountLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "8.4만개의 평가",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let ratingScoreLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "4.4",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    }
    
    private let ratingStarsView = UIView()
    
    private let ratingStarsBackgroundView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let ratingStarsForegroundImageView = UIImageView().then {
        $0.image = UIImage(named: "stars_container")
        $0.contentMode = .scaleAspectFill
    }
    
    private let awardView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
        $0.addRightBorder(color: .lightGray, width: 1, multiplier: 0.4)
    }
    
    private let awardInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "수상",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let awardImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        $0.image = UIImage(systemName: "person", withConfiguration: imageConfig)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let awardInfoSubTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "앱",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .light))
    }
    
    private let ageView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
        $0.addRightBorder(color: .lightGray, width: 1, multiplier: 0.4)
    }
    
    private let ageInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "연령",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let ageLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "4+",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    }
    
    private let ageInfoSubTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "세",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .light))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    deinit {
        print("Detail ViewController Deinit")
    }
    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubViews(
            containerScrollView.addSubViews(
                containerStackView.addArrangedSubViews(
                    // 타이틀 영역
                    titleInfoView.addSubViews(
                        appIconImageView,
                        titleLabelContainerStackView.addArrangedSubViews(
                            titleLabel,
                            descriptionLabel
                        ),
                        downloadButton,
                        shareIconButton
                    ),
                    // 앱 정보 수평 스크롤 뷰
                    appInfoHorizontalSwipeContainerView.addSubViews(
                        appInfoHorizontalSwipeStackView.addArrangedSubViews(
                            // 사용자 평점 뷰
                            ratingView.addArrangedSubViews(
                                ratingCountLabel,
                                ratingScoreLabel,
                                ratingStarsView.addSubViews(
                                    ratingStarsBackgroundView,
                                    ratingStarsForegroundImageView
                                )
                            ),
                            // 수상 뷰
                            awardView.addArrangedSubViews(
                                awardInfoTitleLabel,
                                awardImageView,
                                awardInfoSubTitleLabel
                            ),
                            // 연령 뷰
                            ageView.addArrangedSubViews(
                                ageInfoTitleLabel,
                                ageLabel,
                                ageInfoSubTitleLabel
                            )
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
        
        appIconImageView.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview().inset(20)
            $0.size.equalTo(120)
        }
        
        titleLabelContainerStackView.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.left.equalTo(appIconImageView.snp.right).offset(15)
            $0.right.equalToSuperview().inset(20)
        }
        
        downloadButton.snp.makeConstraints {
            $0.left.equalTo(appIconImageView.snp.right).offset(15)
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(28)
            $0.width.equalTo(68)
        }
        
        shareIconButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(appIconImageView.snp.bottom)
        }
        
        // MARK: 수평 스크롤 뷰
        appInfoHorizontalSwipeContainerView.snp.makeConstraints {
            $0.top.equalTo(titleInfoView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        appInfoHorizontalSwipeStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.height.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints {
            $0.width.equalTo(108)
        }
        
        ratingStarsView.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
        
        ratingStarsBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(4.4 / 5.0)
        }
        
        ratingStarsForegroundImageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.verticalEdges.equalTo(ratingStarsBackgroundView)
        }
        
        awardView.snp.makeConstraints {
            $0.width.equalTo(108)
        }
        
        ageView.snp.makeConstraints {
            $0.width.equalTo(108)
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
