//
//  AppDetailInfoView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class AppDetailInfoView: UIView {
    
    private let containerView = UIView()
    
    private let appDetailInfoLabel = UILabel().then {
        $0.numberOfLines = 3
    }
    
    private let appDetailInfoShowMoreButton = UIButton().then {
        $0.backgroundColor = .white
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "더 보기",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16, weight: .regular)))
        config.contentInsets = .zero
        
        $0.configuration = config
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        
        addSubview(
            containerView.addSubViews(
                appDetailInfoLabel,
                appDetailInfoShowMoreButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        appDetailInfoLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        appDetailInfoShowMoreButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
    
    
    public func setUI(with data: AppDetailInfo) {
         
        clearUI()
        
        guard let appDetailInfoContents = data.content else { return }
        
        // 앱 디테일 정보 레이블 세팅
        appDetailInfoLabel.attributedText = .makeAttributedString(text: appDetailInfoContents,
                                                                  color: .black,
                                                                  font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                                  lineHeightMultiple: 1.4)
        
        // 디테일 정보 텍스트가 3줄을 초과할 경우만 [더 보기] 버튼 노출
        if appDetailInfoLabel.isTextMoreThanLines(3) {
            appDetailInfoShowMoreButton.isHidden = false
        }
    }
    
    
    private func clearUI() {
        appDetailInfoLabel.attributedText = nil
        appDetailInfoLabel.numberOfLines = 3
        
        appDetailInfoShowMoreButton.isHidden = true
    }
    
    
    private func bindAction() {
        appDetailInfoShowMoreButton.addTarget(self,
                                              action: #selector(appDetailInfoShowMoreButtonDidTap),
                                              for: .touchUpInside)
    }
    
    
    @objc private func appDetailInfoShowMoreButtonDidTap() {
        appDetailInfoLabel.numberOfLines = 0
        appDetailInfoShowMoreButton.isHidden = true
    }
}
