//
//  AppRatingView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class AppRatingView: UIView {
    
    private let containerView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let ratingCountLabel = UILabel()
    
    private let averageRatingLabel = UILabel()
    
    private let ratingStarsView = UIView()
    
    private let ratingStarsBackgroundView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let ratingStarsForegroundImageView = UIImageView().then {
        $0.image = UIImage(named: "stars_container")
        $0.contentMode = .scaleAspectFill
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
            containerView.addArrangedSubViews(
                ratingCountLabel,
                averageRatingLabel,
                ratingStarsView.addSubViews(
                    ratingStarsBackgroundView,
                    ratingStarsForegroundImageView
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(108)
        }
        
        ratingStarsView.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
        
        ratingStarsBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0)
        }
        
        ratingStarsForegroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    public func setUI(with data: AppEvaluation) {
        
        clearUI()
        
        guard let totalRating = data.totalReviews,
              let averageRating = data.averageRating,
              let maxRating = data.maxRating else { return }
        
        let totalCountString = NumberFormatter.formatToReviewCountString(totalRating)
        
        // 총 평가 갯수 레이블 세팅
        ratingCountLabel.attributedText = .makeAttributedString(text: "\(totalCountString)개의 평가",
                                                                color: .gray,
                                                                font: UIFont.systemFont(ofSize: 12, weight: .light))
        
        // 평균 점수 레이블 세팅
        averageRatingLabel.attributedText = .makeAttributedString(text: String(averageRating),
                                                                  color: .gray,
                                                                  font: UIFont.systemFont(ofSize: 22, weight: .semibold))
        
        // 별점 아이콘 세팅
        ratingStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(averageRating / maxRating)
        }
    }
    
    
    private func clearUI() {
        ratingCountLabel.attributedText = nil
        averageRatingLabel.attributedText = nil

        ratingStarsBackgroundView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0)
        }
    }
}

