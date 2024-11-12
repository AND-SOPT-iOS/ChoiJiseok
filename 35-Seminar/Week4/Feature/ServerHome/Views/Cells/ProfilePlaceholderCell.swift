//
//  ProfilePlaceholderCell.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import UIKit
import Then
import SnapKit

class ProfilePlaceholderCell: UITableViewCell {
    
    private let placeholderContainerView = UIView()
    
    private let placeholderIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        $0.image = UIImage(systemName: "person.crop.circle", withConfiguration: imageConfig)
        $0.tintColor = .systemBlue
        $0.contentMode = .scaleAspectFit
    }
    
    private let placeholderTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Apple 계정으로 로그인",
                                                  color: .systemBlue,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .medium))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        contentView.addSubViews(
            placeholderContainerView.addSubViews(
                placeholderIconImageView,
                placeholderTitleLabel
            )
        )
        
        placeholderContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeholderIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        placeholderTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(placeholderIconImageView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
    }
}
