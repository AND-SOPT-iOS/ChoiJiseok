//
//  AppSelfRatingAndReviewView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

class AppSelfRatingAndReviewView: UIView {
    
    private let containerView = UIView()
    
    private let selfRatingAndReviewTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "탭하여 평가하기",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .medium))
    }
    
    private let selfRatingStarIconsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let firstStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.setImage(image, for: .highlighted)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let secondStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.setImage(image, for: .highlighted)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let thirdStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.setImage(image, for: .highlighted)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let fourthStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.setImage(image, for: .highlighted)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let fifthStarIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.setImage(image, for: .highlighted)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        
        addSubview(
            containerView.addSubViews(
                selfRatingAndReviewTitleInfoLabel,
                selfRatingStarIconsStackView.addArrangedSubViews(
                    firstStarIconButton,
                    secondStarIconButton,
                    thirdStarIconButton,
                    fourthStarIconButton,
                    fifthStarIconButton
                ),
                selfRatingButtonsStackView.addArrangedSubViews(
                    selfReviewWritingButton,
                    appSupportButton
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
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
            $0.left.right.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    private func bindAction() {
        firstStarIconButton.addTarget(self, action: #selector(firstStarIconButtonIsPressed), for: [.touchUpInside])
        secondStarIconButton.addTarget(self, action: #selector(secondStarIconButtonIsPressed), for: [.touchUpInside])
        thirdStarIconButton.addTarget(self, action: #selector(thirdStarIconButtonIsPressed), for: [.touchUpInside])
        fourthStarIconButton.addTarget(self, action: #selector(fourthStarIconButtonIsPressed), for: [.touchUpInside])
        fifthStarIconButton.addTarget(self, action: #selector(fifthStarIconButtonIsPressed), for: [.touchUpInside])
    }
    
    
    @objc private func firstStarIconButtonIsPressed() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let starIcon = UIImage(systemName: "star", withConfiguration: imageConfig)
        let filledStarIcon = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        firstStarIconButton.setImage(filledStarIcon, for: .normal)
        firstStarIconButton.setImage(filledStarIcon, for: .highlighted)
        secondStarIconButton.setImage(starIcon, for: .normal)
        secondStarIconButton.setImage(starIcon, for: .highlighted)
        thirdStarIconButton.setImage(starIcon, for: .normal)
        thirdStarIconButton.setImage(starIcon, for: .highlighted)
        fourthStarIconButton.setImage(starIcon, for: .normal)
        fourthStarIconButton.setImage(starIcon, for: .highlighted)
        fifthStarIconButton.setImage(starIcon, for: .normal)
        fourthStarIconButton.setImage(starIcon, for: .highlighted)
    }
    
    
    @objc private func secondStarIconButtonIsPressed() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let starIcon = UIImage(systemName: "star", withConfiguration: imageConfig)
        let filledStarIcon = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        firstStarIconButton.setImage(filledStarIcon, for: .normal)
        firstStarIconButton.setImage(filledStarIcon, for: .highlighted)
        secondStarIconButton.setImage(filledStarIcon, for: .normal)
        secondStarIconButton.setImage(filledStarIcon, for: .highlighted)
        thirdStarIconButton.setImage(starIcon, for: .normal)
        thirdStarIconButton.setImage(starIcon, for: .highlighted)
        fourthStarIconButton.setImage(starIcon, for: .normal)
        fourthStarIconButton.setImage(starIcon, for: .highlighted)
        fifthStarIconButton.setImage(starIcon, for: .normal)
        fourthStarIconButton.setImage(starIcon, for: .highlighted)
    }
    
    
    @objc private func thirdStarIconButtonIsPressed() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let starIcon = UIImage(systemName: "star", withConfiguration: imageConfig)
        let filledStarIcon = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        firstStarIconButton.setImage(filledStarIcon, for: .normal)
        firstStarIconButton.setImage(filledStarIcon, for: .highlighted)
        secondStarIconButton.setImage(filledStarIcon, for: .normal)
        secondStarIconButton.setImage(filledStarIcon, for: .highlighted)
        thirdStarIconButton.setImage(filledStarIcon, for: .normal)
        thirdStarIconButton.setImage(filledStarIcon, for: .highlighted)
        fourthStarIconButton.setImage(starIcon, for: .normal)
        fourthStarIconButton.setImage(starIcon, for: .highlighted)
        fifthStarIconButton.setImage(starIcon, for: .normal)
        fourthStarIconButton.setImage(starIcon, for: .highlighted)
    }
    
    
    @objc private func fourthStarIconButtonIsPressed() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let starIcon = UIImage(systemName: "star", withConfiguration: imageConfig)
        let filledStarIcon = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        firstStarIconButton.setImage(filledStarIcon, for: .normal)
        firstStarIconButton.setImage(filledStarIcon, for: .highlighted)
        secondStarIconButton.setImage(filledStarIcon, for: .normal)
        secondStarIconButton.setImage(filledStarIcon, for: .highlighted)
        thirdStarIconButton.setImage(filledStarIcon, for: .normal)
        thirdStarIconButton.setImage(filledStarIcon, for: .highlighted)
        fourthStarIconButton.setImage(filledStarIcon, for: .normal)
        fourthStarIconButton.setImage(filledStarIcon, for: .highlighted)
        fifthStarIconButton.setImage(starIcon, for: .normal)
        fourthStarIconButton.setImage(starIcon, for: .highlighted)
    }
    
    
    @objc private func fifthStarIconButtonIsPressed() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let starIcon = UIImage(systemName: "star", withConfiguration: imageConfig)
        let filledStarIcon = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        firstStarIconButton.setImage(filledStarIcon, for: .normal)
        firstStarIconButton.setImage(filledStarIcon, for: .highlighted)
        secondStarIconButton.setImage(filledStarIcon, for: .normal)
        secondStarIconButton.setImage(filledStarIcon, for: .highlighted)
        thirdStarIconButton.setImage(filledStarIcon, for: .normal)
        thirdStarIconButton.setImage(filledStarIcon, for: .highlighted)
        fourthStarIconButton.setImage(filledStarIcon, for: .normal)
        fourthStarIconButton.setImage(filledStarIcon, for: .highlighted)
        fifthStarIconButton.setImage(filledStarIcon, for: .normal)
        fourthStarIconButton.setImage(filledStarIcon, for: .highlighted)
    }
}



