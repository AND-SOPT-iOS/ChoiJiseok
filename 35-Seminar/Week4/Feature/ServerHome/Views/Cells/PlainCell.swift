//
//  PlainCell.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import Then
import SnapKit

class PlainTableViewCell: UITableViewCell {
    
    private let mainTitleLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let rightSideContentsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.alignment = .center
    }
    
    private let rightSideSubTitleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.isHidden = true
    }
    
    private let rightSideArrowIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        $0.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        $0.tintColor = .lightGray
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    private func makeUI() {
        contentView.addSubViews(
            mainTitleLabel,
            rightSideContentsStackView.addArrangedSubViews(
                rightSideSubTitleLabel,
                rightSideArrowIconImageView
            )
        )
        
        mainTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightSideContentsStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        rightSideSubTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        rightSideArrowIconImageView.snp.makeConstraints {
            $0.size.equalTo(18)
        }
    }
    
    public func setUI(title: String,
                      titleColor: UIColor,
                      subTitle: String?,
                      shouldShowArrowIcon: Bool) {
        
        // Title label setup
        mainTitleLabel.attributedText = .makeAttributedString(text: title,
                                                              color: titleColor,
                                                              font: .systemFont(ofSize: 18, weight: .regular))
        
        // Right side subtitle setup
        if let subTitle = subTitle {
            rightSideSubTitleLabel.attributedText = .makeAttributedString(text: subTitle,
                                                                          color: .lightGray,
                                                                          font: .systemFont(ofSize: 18, weight: .regular))
            rightSideSubTitleLabel.isHidden = false
        } else {
            rightSideSubTitleLabel.isHidden = true
        }
        
        // Right side arrow icon setup
        rightSideArrowIconImageView.isHidden = !shouldShowArrowIcon
    }
    
    private func clearUI() {
        mainTitleLabel.attributedText = nil
        rightSideSubTitleLabel.attributedText = nil
        rightSideSubTitleLabel.isHidden = true
        rightSideArrowIconImageView.isHidden = true
    }
}
