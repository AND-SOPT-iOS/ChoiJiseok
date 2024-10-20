//
//  AppSelfRatingAndReviewView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

public protocol AppSelfRatingAndReviewViewDelegate: AnyObject {
    func didReceiveUserRating(rating: Int)
}

final class AppSelfRatingAndReviewView: UIView {
    
    weak var delegate: AppSelfRatingAndReviewViewDelegate?

    private let containerView = UIView()
    
    private var ratingTask: Task<Void, Never>? = nil

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

    private let starIconButtons: [UIButton] = (0..<5).map { buttonIndex in
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        button.tag = buttonIndex + 1  // 버튼에 태그를 설정하여 구분
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
    
    deinit {
        // 기존 Task 취소
        cancelRatingTask()
        
        print("AppSelfRatingAndReviewView Deinit")
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
        // 별점 아이콘 버튼 터치 이벤트 바인딩
        for button in starIconButtons {
            button.addTarget(self, action: #selector(starIconButtonTapped(_:)), for: [.touchUpInside])
        }
        
        // 별점 버튼 pressed(드래그) 이벤트 바인딩
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleStarIconButtonGesture))
        selfRatingStarIconsStackView.addGestureRecognizer(panGesture)
    }
    
    
    @objc private func starIconButtonTapped(_ sender: UIButton) {
        let rating = sender.tag
        // 별점 아이콘 설정
        updateStarRating(with: rating)
        // 기존 Rating Task 취소
        cancelRatingTask()
        // Rating Task 세팅
        setRatingTask(with: rating)
    }
    
    
    @objc private func handleStarIconButtonGesture(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: selfRatingStarIconsStackView)  // 드래그 중인 위치
        for button in starIconButtons {
            if button.frame.contains(location) {
                let rating = button.tag

                // 별점 아이콘 설정
                updateStarRating(with: rating)
                // 기존 Rating Task 취소
                cancelRatingTask()
                // Rating Task 세팅
                setRatingTask(with: rating)
            }
        }
    }
    
    
    /// 터치, 혹은 드래그를 통한 별점 아이콘 선택 시,
    /// 가장 마지막에 선택한 별점만 반영되도록 구현
    private func setRatingTask(with rating: Int) {
        ratingTask = Task(priority: .userInitiated) { [weak self] in
            try? await Task.sleep(nanoseconds: 500_000_000)  // 0.5초 대기. Task가 cancel되면 여기서 Error가 발생
            guard let self else { return }
            if !Task.isCancelled {
                delegate?.didReceiveUserRating(rating: rating)
            }
        }
    }
    
    
    /// 기존 Rating Task 취소
    private func cancelRatingTask() {
        ratingTask?.cancel()
        ratingTask = nil
    }


    /// 별점 아이콘 업데이트
    private func updateStarRating(with selectedRating: Int) {
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
