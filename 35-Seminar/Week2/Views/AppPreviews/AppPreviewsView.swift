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
    
    private let previewImagesContainerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
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
                previewImagesContainerStackView
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
        
        previewImagesContainerStackView.snp.makeConstraints {
            $0.top.equalTo(previewInfoTitleLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    public func setUI(with data: PreviewImages) {
        
        clearUI()
        
        guard let images = data.images else { return }
        
        // 프리뷰 이미지 세팅
        for imageURL in images {
            let previewImageView = UIImageView().then {
                $0.image = UIImage(named: imageURL)
                $0.contentMode = .scaleAspectFill
                $0.layer.cornerRadius = 24
                $0.clipsToBounds = true
                $0.layer.borderWidth = 0.5
                $0.layer.borderColor = UIColor.lightGray.cgColor
            }
            
            previewImagesContainerStackView.addArrangedSubview(previewImageView)
            
            previewImageView.snp.makeConstraints {
                $0.height.equalToSuperview()
                $0.width.equalTo(215)
            }
        }
    }
    
    private func clearUI() {
        for subview in previewImagesContainerStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
