//
//  AppPreviewsView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

class AppPreviewsView: UIView {
    
    private let containerView = UIView()
    
    private let previewInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "미리 보기",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 22, weight: .bold))
    }
    
    private let previewImagesContainerView = UIView()
    
    private let firstPreviewImageView = UIImageView().then {
        $0.image = UIImage(named: "toss_preview_1")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
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
                previewInfoTitleLabel,
                previewImagesContainerView.addSubViews(
                    firstPreviewImageView
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(496)
        }
        
        previewInfoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        previewImagesContainerView.snp.makeConstraints {
            $0.top.equalTo(previewInfoTitleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        firstPreviewImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.width.equalTo(215)
        }
    }
}
