//
//  AppNewNoticeView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

class AppNewUpdateView: UIView {
    
    private let containerView = UIView()
    
    private let newNoticeButton = UIButton().then {
        
        var config = UIButton.Configuration.plain()
        // 타이틀
        config.attributedTitle = AttributedString(.makeAttributedString(text: "새로운 소식",
                                                                        color: .black,
                                                                        font: UIFont.systemFont(ofSize: 22,
                                                                                                weight: .black)))
        // 이미지
        config.image = UIImage(systemName: "chevron.right")
        config.imagePadding = 2
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14,
                                                                                  weight: .heavy)
        config.baseForegroundColor = .gray
        // 상하좌우 패딩
        config.contentInsets = .zero
        
        $0.configuration = config
    }
    
    private let newAppVersionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "버전 5.185.0",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    private let elapsedDaysLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "1일 전",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    private let versionChangeLogLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.attributedText = .makeAttributedString(text: "• 구석구석 숨어있던 버그들을 잡았어요. 또 다른 버그가 나타나면 토스 고객센터를 찾아주세요. 늘 열려있답니다. 365일 24시간 언제든지요.",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                  lineHeightMultiple: 1.4)
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
                newNoticeButton,
                newAppVersionLabel,
                elapsedDaysLabel,
                versionChangeLogLabel
            )
        )
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        newNoticeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        newAppVersionLabel.snp.makeConstraints {
            $0.top.equalTo(newNoticeButton.snp.bottom).offset(12)
            $0.left.equalToSuperview()
        }
        
        elapsedDaysLabel.snp.makeConstraints {
            $0.top.equalTo(newNoticeButton.snp.bottom).offset(12)
            $0.right.equalToSuperview()
        }
        
        versionChangeLogLabel.snp.makeConstraints {
            $0.top.equalTo(elapsedDaysLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
