//
//  appTitleInfoView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit

class AppTitleInfoView: UIView {
    
    private let containerView = UIView()
    
    private let titleLabelContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    private let appIconImageView = UIImageView().then {
        $0.image = UIImage(named: "toss_icon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Week2ColorSet.logoImageBorderColor.cgColor
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "토스",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    }
    
    private let descriptionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "금융이 쉬워진다.",
                                                  color: .lightGray,
                                                  font: UIFont.systemFont(ofSize: 15, weight: .medium))
    }
    
    private let downloadButton = UIButton().then {
        $0.backgroundColor = UIColor.Week2ColorSet.primaryBlue
        $0.setTitle("열기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setAttributedTitle(.makeAttributedString(text: "열기",
                                                    color: .white,
                                                    font: UIFont.systemFont(ofSize: 15, weight: .semibold)),
                              for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 14
    }
    
    private let shareIconButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
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
                titleLabelContainerStackView.addArrangedSubViews(
                    titleLabel,
                    descriptionLabel
                ),
                downloadButton,
                shareIconButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        appIconImageView.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.size.equalTo(120)
        }
        
        titleLabelContainerStackView.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.left.equalTo(appIconImageView.snp.right).offset(15)
            $0.right.equalToSuperview()
        }
        
        downloadButton.snp.makeConstraints {
            $0.left.equalTo(appIconImageView.snp.right).offset(15)
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(28)
            $0.width.equalTo(68)
        }
        
        shareIconButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalTo(appIconImageView.snp.bottom)
        }
    }
}
