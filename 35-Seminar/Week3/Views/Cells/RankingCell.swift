//
//  PaidRankingCell.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

import UIKit
import SnapKit
import Then

final class RankingCell: UICollectionViewCell {
    
    private let containerView = UIView()
    
    private let appIconImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Week3ColorSet.logoImageBorderColor.cgColor
    }
    
    private let rankingLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let appTitleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
    }
    
    private let appTitleLabel = UILabel().then {
        $0.numberOfLines = 2
    }
    
    private let appDescriptionLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let downloadButton = UIButton().then {
        $0.backgroundColor = UIColor.Week3ColorSet.buttonBackgroundLightGray
        $0.setAttributedTitle(.makeAttributedString(text: "받기",
                                                    color: .systemBlue,
                                                    font: UIFont.systemFont(ofSize: 15, weight: .semibold)),
                              for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    private let inAppPurchasesLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "앱 내 구입",
                                                  color: .lightGray,
                                                  font: UIFont.systemFont(ofSize: 8, weight: .medium))
    }
    
    private let bottomLineView = UIView().then {
        $0.backgroundColor = UIColor.Week3ColorSet.borderGray
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
                appIconImageView,
                rankingLabel,
                appTitleStackView.addArrangedSubViews(
                    appTitleLabel,
                    appDescriptionLabel
                ),
                downloadButton,
                inAppPurchasesLabel,
                bottomLineView
            )
        )
        
        containerView.snp.makeConstraints {
            $0.height.equalTo(72)
            $0.left.right.bottom.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        rankingLabel.snp.makeConstraints {
            $0.top.equalTo(appTitleStackView.snp.top)
            $0.left.equalTo(appIconImageView.snp.right).offset(10)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        inAppPurchasesLabel.snp.makeConstraints {
            $0.centerX.equalTo(downloadButton)
            $0.top.equalTo(downloadButton.snp.bottom).offset(3)
        }
        
        appTitleStackView.snp.makeConstraints {
            $0.left.equalTo(rankingLabel.snp.right).offset(15)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(downloadButton.snp.left).offset(-14)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.equalTo(appTitleStackView.snp.left)
            $0.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    
    public func setUI(with item: RankingItem) {
        
        clearUI()
        
        if let imageUrl = item.imageUrl {
            appIconImageView.image = UIImage(named: imageUrl)
        }
        
        if let ranking = item.ranking {
            rankingLabel.attributedText = .makeAttributedString(text: "\(ranking)",
                                                                color: .black,
                                                                font: UIFont.systemFont(ofSize: 16, weight: .bold))
        }
            
        if let title = item.title {
            appTitleLabel.attributedText = .makeAttributedString(text: title,
                                                                 color: .black,
                                                                 font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                                 lineBreakMode: .byTruncatingTail)
        }

        if let description = item.description {
            appDescriptionLabel.attributedText = .makeAttributedString(text: description,
                                                                       color: .gray,
                                                                       font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                       lineBreakMode: .byTruncatingTail)
        }

        if let inAppPurchaseExists = item.inAppPurchaseExists, inAppPurchaseExists {
            inAppPurchasesLabel.isHidden = false
        } else {
            inAppPurchasesLabel.isHidden = true
        }
    }

    
    private func clearUI() {
        appTitleLabel.attributedText = nil
        appDescriptionLabel.attributedText = nil
        rankingLabel.attributedText = nil
        appIconImageView.image = nil
        inAppPurchasesLabel.isHidden = true
    }
    
    
    public func showBottomLine(_ shouldShowBottomLine: Bool) {
        bottomLineView.isHidden = !shouldShowBottomLine
    }
}


