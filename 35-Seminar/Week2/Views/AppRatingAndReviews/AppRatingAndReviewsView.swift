//
//  AppRatingAndReviewsView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

class AppRatingAndReviewsView: UIView {
    
    private let containerView = UIView()
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        
        addSubview(
            containerView.addSubViews(
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
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ratingAndReviewsButton.snp.makeConstraints {
            $0.top.equalToSuperview()
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
    }
}

