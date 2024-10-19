//
//  AppShortInfoView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

class AppShortInfoSwipeView: UIView {
    
    private let containerView = UIView()
    
    private let horizonalSwipeStackView = UIStackView().then {
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
                horizonalSwipeStackView.addArrangedSubViews(
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
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        horizonalSwipeStackView.snp.makeConstraints {
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
