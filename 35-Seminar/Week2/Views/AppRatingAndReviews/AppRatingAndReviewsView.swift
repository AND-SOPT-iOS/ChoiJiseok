//
//  AppRatingAndReviewsView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then


public protocol AppRatingAndReviewsViewDelegate: AnyObject {
    func ratingAndReviewsButtonDidTap()
}

class AppRatingAndReviewsView: UIView {
    
    weak var delegate: AppRatingAndReviewsViewDelegate?
    
    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 12
        $0.insetsLayoutMarginsFromSafeArea = false
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 22, trailing: 0)
    }
    
    private let ratingContainerView = UIView()
    
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
    
    private let averageRatingLabel = UILabel()
    
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
    
    private let reviewContainerView = UIView()
    
    private let mostHelpfulReviewTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "가장 도움이 되는 리뷰",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .semibold))
    }
    
    private let userReviewsContainerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.insetsLayoutMarginsFromSafeArea = false
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
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
            containerStackView.addArrangedSubViews(
                // 평점 컨테이너
                ratingContainerView.addSubViews(
                    ratingAndReviewsButton,
                    averageRatingLabel,
                    ratingAndReviewsStackView.addArrangedSubViews(
                        ratingAndReviewsStarsView.addSubViews(
                            ratingAndReviewsStarsBackgroundView,
                            ratingAndReviewsStarsForegroundImageView
                        ),
                        ratingAndReviewsCountLabel
                    )
                ),
                // 사용자 리뷰 컨테이너
                reviewContainerView.addSubViews(
                    mostHelpfulReviewTitleInfoLabel,
                    userReviewsContainerStackView
                )
            )
        )
        
        // MARK: - 평점 컨테이너
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ratingAndReviewsButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
        averageRatingLabel.snp.makeConstraints {
            $0.top.equalTo(ratingAndReviewsButton.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
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
            $0.width.equalToSuperview().multipliedBy(0)
        }
        
        ratingAndReviewsStarsForegroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // MARK: - 사용자 리뷰 컨테이너
        mostHelpfulReviewTitleInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
        userReviewsContainerStackView.snp.makeConstraints {
            $0.top.equalTo(mostHelpfulReviewTitleInfoLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
    public func setUI(with data: RatingAndReviews) {
        
        clearUI()
        
        guard let averageRating = data.averageRating,
              let maxRating = data.maxRating,
              let totalRating = data.totalReviews else { return }
                
        // 평균 점수 레이블 세팅
        averageRatingLabel.attributedText = .makeAttributedString(text: String(averageRating),
                                                                  color: .black,
                                                                  font: UIFont.systemFont(ofSize: 64, weight: .bold))

        // 별점 아이콘 세팅
        ratingAndReviewsStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(averageRating / maxRating)
        }
              
        // 총 평가 갯수 레이블 세팅
        let totalCountString = NumberFormatter.formatToReviewCountString(totalRating)
        ratingAndReviewsCountLabel.attributedText = .makeAttributedString(text: "\(totalCountString)개의 평가",
                                                                          color: .gray,
                                                                          font: UIFont.systemFont(ofSize: 17, weight: .medium))
        
        // 사용자 리뷰 세팅
        guard let userReviews = data.mostHelpfulReviews, !userReviews.isEmpty else { return }
        
        for review in userReviews {
            let userReviewCell = UserReviewCell()
            userReviewCell.setUI(with: review)
            
            userReviewsContainerStackView.addArrangedSubview(userReviewCell)
        }

        reviewContainerView.isHidden = false
    }
    
    
    private func clearUI() {
        averageRatingLabel.attributedText = nil
        ratingAndReviewsCountLabel.attributedText = nil
        
        ratingAndReviewsStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0)
        }
        
        for subview in userReviewsContainerStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }

        reviewContainerView.isHidden = true
    }
    
    
    private func bindAction() {
        ratingAndReviewsButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            delegate?.ratingAndReviewsButtonDidTap()
        }), for: .touchUpInside)
    }
}

