//
//  AppNewUpdatesView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

class AppNewUpdatesView: UIView {
    
    private let containerView = UIView()
    
    private let newUpdatesButton = UIButton().then {
        
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
    
    private let newAppVersionLabel = UILabel()
    
    private let elapsedDaysLabel = UILabel()
    
    private let versionChangeLogLabel = UILabel().then {
        $0.numberOfLines = 0
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
                newUpdatesButton,
                newAppVersionLabel,
                elapsedDaysLabel,
                versionChangeLogLabel
            )
        )
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        newUpdatesButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        newAppVersionLabel.snp.makeConstraints {
            $0.top.equalTo(newUpdatesButton.snp.bottom).offset(12)
            $0.left.equalToSuperview()
        }
        
        elapsedDaysLabel.snp.makeConstraints {
            $0.top.equalTo(newUpdatesButton.snp.bottom).offset(12)
            $0.right.equalToSuperview()
        }
        
        versionChangeLogLabel.snp.makeConstraints {
            $0.top.equalTo(elapsedDaysLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
    public func setUI(with data: AppUpdates) {
        
        clearUI()
        
        guard let appVersion = data.version,
              let elapsedDays = data.elapsedDays,
              let changeLog = data.content else { return }
        
        // 앱 버전 레이블 세팅
        newAppVersionLabel.attributedText = .makeAttributedString(text: "버전 \(appVersion)",
                                                                  color: .gray,
                                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular))
        
        // 앱 배포 경과 일자 레이블 세팅
        elapsedDaysLabel.attributedText = .makeAttributedString(text: elapsedDays,
                                                                color: .gray,
                                                                font: UIFont.systemFont(ofSize: 16, weight: .regular))
        
        // 앱 버전 체인지 로그 레이블 세팅
        versionChangeLogLabel.attributedText = .makeAttributedString(text: changeLog,
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                  lineHeightMultiple: 1.4)
    }
    
    public func clearUI() {
        newAppVersionLabel.attributedText = nil
        elapsedDaysLabel.attributedText = nil
        versionChangeLogLabel.attributedText = nil
    }
}
