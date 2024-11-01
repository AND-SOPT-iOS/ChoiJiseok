//
//  SectionHeaderView.swift
//  35-Seminar
//
//  Created by 최지석 on 11/1/24.
//

import UIKit
import SnapKit
import Then

class SectionHeaderView: UICollectionReusableView {
    
    static let identifier = "EssentialSectionHeaderView"
    
    private let containerView = UIView()
    
    private let titleContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .leading
    }
    
    private let titleHorizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    private let titleLabel = UILabel()
    
    private let rightIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        $0.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    
    private func setupUI() {
        addSubViews(
            containerView.addSubViews(
                titleContainerStackView.addArrangedSubViews(
                    titleHorizontalStackView.addArrangedSubViews(
                        titleLabel,
                        rightIconImageView,
                        UIView()
                    ),
                    descriptionLabel
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleContainerStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    
    public func setUI(with title: String?, description: String?) {
        
        clearUI()
        
        if let title {
            titleLabel.attributedText = .makeAttributedString(text: title,
                                                              color: .black,
                                                              font: UIFont.systemFont(ofSize: 22,
                                                                                      weight: .bold))
        }
        
        if let description {
            descriptionLabel.attributedText = .makeAttributedString(text: description,
                                                                    color: .lightGray,
                                                                    font: UIFont.systemFont(ofSize: 14,
                                                                                            weight: .regular))
        }
    }
    
    
    private func clearUI() {
        titleLabel.attributedText = nil
        descriptionLabel.attributedText = nil
    }
}
