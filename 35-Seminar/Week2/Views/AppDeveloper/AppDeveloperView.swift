//
//  AppDeveloperView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class AppDeveloperView: UIView {
    
    private let containerView = UIView()

    private let developerNameLabel = UILabel()

    private let developerTitleInfoLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "개발자",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }

    private let developerInfoArrowIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        $0.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        $0.tintColor = .gray
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
                developerNameLabel,
                developerTitleInfoLabel,
                developerInfoArrowIconImageView
            )
        )
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        developerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        developerTitleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(developerNameLabel.snp.bottom).offset(3)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        developerInfoArrowIconImageView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
    }
    
    
    public func setUI(with data: DeveloperInfo) {
        
        clearUI()
        
        guard let developerName = data.developerName else { return }
        
        // 개발자 이름 세팅
        developerNameLabel.attributedText = .makeAttributedString(text: developerName,
                                                                  color: .systemBlue,
                                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    
    private func clearUI() {
        developerNameLabel.attributedText = nil
    }
}
