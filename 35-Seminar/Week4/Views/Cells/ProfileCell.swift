//
//  ProfileCell.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import Then
import SnapKit

class ProfileCell: UITableViewCell {
    
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
    
    private let profileContainerView = UIView()
    
    private let profileThumbnailImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        $0.image = UIImage(systemName: "person.crop.circle", withConfiguration: imageConfig)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let profileContentsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
    }

    private let profileUserNameLabel = UILabel()
    
    private let profileUserEmailLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Testflight@gmail.com",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .regular))
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
        
        showPlaceholder()
    }
    
    
    private func makeUI() {
        contentView.addSubViews(
            // 플레이스 홀더
            placeholderContainerView.addSubViews(
                placeholderIconImageView,
                placeholderTitleLabel
            ),
            // 유저 프로필
            profileContainerView.addSubViews(
                profileThumbnailImageView,
                profileContentsStackView.addArrangedSubViews(
                    profileUserNameLabel,
                    profileUserEmailLabel
                )
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
        
        profileContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileThumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        profileContentsStackView.snp.makeConstraints {
            $0.leading.equalTo(profileThumbnailImageView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
        
        showPlaceholder()
    }
    
    
    public func showPlaceholder() {
        placeholderContainerView.isHidden = false
        profileContainerView.isHidden = true
    }
    
    
    public func showUserProfile(name: String?) {
        placeholderContainerView.isHidden = true
        profileContainerView.isHidden = false
        
        profileUserNameLabel.attributedText = .makeAttributedString(text: name ?? "이름 없음",
                                                                    color: .black,
                                                                    font: UIFont.systemFont(ofSize: 20, weight: .medium))
    }
}
