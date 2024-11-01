//
//  RecommendCell.swift
//  35-Seminar
//
//  Created by 최지석 on 11/1/24.
//

import UIKit
import SnapKit
import Then


final class RecommendCell: UICollectionViewCell {
    
    private let containerView = UIView()

    // MARK: 헤더
    private let appInfoHeaderView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .leading
    }
    
    private let headerAdditionalTextLabel = UILabel()
    
    private let headerTitleLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let headerDescriptionLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    // MARK: 콘텐츠
    private let appInfoContentsView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .lightGray
    }
    
    private let bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }

    private let contentsContainerView = UIView()
    
    private let appIconImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let appTitleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
    }
    
    private let appTitleLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let appSubTextLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let downloadButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setAttributedTitle(.makeAttributedString(text: "받기",
                                                    color: .white,
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyGradient()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    
    public func makeUI() {
        addSubViews(
            containerView.addSubViews(
                appInfoHeaderView.addArrangedSubViews(
                    headerAdditionalTextLabel,
                    headerTitleLabel,
                    headerDescriptionLabel
                ),
                appInfoContentsView.addSubViews(
                    bannerImageView,
                    contentsContainerView.addSubViews(
                        appIconImageView,
                        appTitleStackView.addArrangedSubViews(
                            appTitleLabel,
                            appSubTextLabel
                        ),
                        downloadButton,
                        inAppPurchasesLabel
                    )
                )
                
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        appInfoHeaderView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        appInfoContentsView.snp.makeConstraints {
            $0.top.equalTo(appInfoHeaderView.snp.bottom).offset(5)
            $0.left.right.bottom.equalToSuperview()
        }
        
        appInfoContentsView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentsContainerView.snp.makeConstraints {
            $0.height.equalTo(68)
            $0.left.right.bottom.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(14)
            $0.size.equalTo(40)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        inAppPurchasesLabel.snp.makeConstraints {
            $0.centerX.equalTo(downloadButton)
            $0.top.equalTo(downloadButton.snp.bottom).offset(2)
        }
        
        appTitleStackView.snp.makeConstraints {
            $0.left.equalTo(appIconImageView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(downloadButton.snp.left).offset(-14)
        }
    }
    
    
    public func setUI(with data: BannerSection) {
        
        clearUI()
        
        if let additionalText = data.additionalText {
            headerAdditionalTextLabel.attributedText = .makeAttributedString(text: additionalText,
                                                                             color: .systemBlue,
                                                                             font: UIFont.systemFont(ofSize: 12, weight: .medium)
            )
        }

        if let title = data.title {
            headerTitleLabel.attributedText = .makeAttributedString(text: title,
                                                                    color: .black,
                                                                    font: UIFont.systemFont(ofSize: 20, weight: .medium),
                                                                    lineBreakMode: .byTruncatingTail)
        }

        if let description = data.description {
            headerDescriptionLabel.attributedText = .makeAttributedString(text: description,
                                                                          color: .darkGray,
                                                                          font: UIFont.systemFont(ofSize: 20, weight: .medium),
                                                                          lineBreakMode: .byTruncatingTail)
        }

        if let fullImageUrl = data.fullImageUrl {
            bannerImageView.image = UIImage(named: fullImageUrl)
        }

        if let appIconUrl = data.appIconUrl {
            appIconImageView.image = UIImage(named: appIconUrl)
        }

        if let title = data.title {
            appTitleLabel.attributedText = .makeAttributedString(text: title,
                                                                 color: .white,
                                                                 font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                                 lineBreakMode: .byTruncatingTail)
        }
        
        if let subText = data.subText {
            appSubTextLabel.attributedText = .makeAttributedString(text: subText,
                                                                   color: .lightGray,
                                                                   font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                   lineBreakMode: .byTruncatingTail)
        }

        if let inAppPurchaseExists = data.inAppPurchaseExists, inAppPurchaseExists {
            inAppPurchasesLabel.isHidden = false
        } else {
            inAppPurchasesLabel.isHidden = true
        }
    }

    
    private func clearUI() {
        removeGradient()
        
        headerAdditionalTextLabel.attributedText = nil
        headerTitleLabel.attributedText = nil
        headerDescriptionLabel.attributedText = nil
        bannerImageView.image = nil
        appIconImageView.image = nil
        appTitleLabel.attributedText = nil
        appSubTextLabel.attributedText = nil
        inAppPurchasesLabel.isHidden = true
    }
    
    
    private func applyGradient() {
        removeGradient()

        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "backgroundGradient"
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0.0, 0.9]
        gradientLayer.frame = contentsContainerView.bounds

        contentsContainerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    private func removeGradient() {
        contentsContainerView.layer.sublayers?.forEach { layer in
            if layer.name == "backgroundGradient" {
                layer.removeFromSuperlayer()
            }
        }
    }
}
