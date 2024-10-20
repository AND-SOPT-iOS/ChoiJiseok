//
//  UserReviewCell.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class UserReviewCell: UIView {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowRadius = 6
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowOpacity = 0.4
        $0.layer.masksToBounds = false
        
        $0.layer.cornerRadius = 16
    }
    
    private let userReviewTitleLabel = UILabel()
    
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
    
    private let userReviewDateAndNameLabel = UILabel()
    
    private let userReviewLabel = UILabel().then {
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
                userReviewTitleLabel,
                userReviewStarsView.addSubViews(
                    userReviewStarsBackgroundView,
                    userReviewStarsForegroundImageView
                ),
                userReviewDateAndNameLabel,
                userReviewLabel
            )
        )
        
        containerView.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.edges.equalToSuperview()
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
            $0.width.equalToSuperview().multipliedBy(0)
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
    
    
    public func setUI(with data: UserReview) {
        
        clearUI()
        
        guard let reviewTitle = data.title,
              let userName = data.userName,
              let reviewDate = data.reviewDate,
              let userRating = data.userRating,
              let maxRating = data.maxRating,
              let content = data.content else { return }
        
        // 리뷰 타이틀 레이블 세팅
        userReviewTitleLabel.attributedText = .makeAttributedString(text: reviewTitle,
                                                                    color: .black,
                                                                    font: UIFont.systemFont(ofSize: 18, weight: .medium))
        
        // 사용자 평점 아이콘 세팅
        userReviewStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(userRating / maxRating)
        }
        
        // 평가 날짜 레이블 세팅
        userReviewDateAndNameLabel.attributedText = .makeAttributedString(text: "\(reviewDate) · \(userName)",
                                                                          color: .gray,
                                                                          font: UIFont.systemFont(ofSize: 14, weight: .regular))
        
        // 리뷰 내용 레이블 세팅
        userReviewLabel.attributedText = .makeAttributedString(text: content,
                                                               color: .gray,
                                                               font: UIFont.systemFont(ofSize: 14, weight: .regular),
                                                               lineBreakMode: .byTruncatingTail,
                                                               lineBreakStrategy: .hangulWordPriority)
    }
    
    
    private func clearUI() {
        userReviewTitleLabel.attributedText = nil
        userReviewDateAndNameLabel.attributedText = nil
        userReviewLabel.attributedText = nil
        
        userReviewStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0)
        }
    }
}
