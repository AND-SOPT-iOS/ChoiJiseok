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

    private let starIconButtons: [UIButton] = (0..<5).map { _ in
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        button.tintColor = .systemBlue
        button.contentMode = .scaleAspectFit
        return button
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
        bindActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeUI() {

        addSubview(
            containerView.addSubViews(
                selfRatingAndReviewTitleInfoLabel,
                selfRatingStarIconsStackView.addArrangedSubViews(
                    starIconButtons
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

    private func bindActions() {
        for (index, button) in starIconButtons.enumerated() {
            button.tag = index + 1  // 버튼에 태그를 설정하여 구분
            button.addTarget(self, action: #selector(starIconButtonTapped(_:)), for: [.touchUpInside])
        }
    }

    @objc private func starIconButtonTapped(_ sender: UIButton) {
        updateStarRating(selectedRating: sender.tag)
    }

    private func updateStarRating(selectedRating: Int) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let filledStarIcon = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        let emptyStarIcon = UIImage(systemName: "star", withConfiguration: imageConfig)

        for (index, button) in starIconButtons.enumerated() {
            let image = index < selectedRating ? filledStarIcon : emptyStarIcon
            button.setImage(image, for: .normal)
            button.setImage(image, for: .highlighted)
        }
    }
}
