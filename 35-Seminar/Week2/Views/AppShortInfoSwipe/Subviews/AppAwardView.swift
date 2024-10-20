//
//  AppAwardView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class AppAwardView: UIView {
    
    private let containerView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let awardInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "수상",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let awardImageView = UIImageView().then {
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let awardInfoSubTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "앱",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .light))
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
            containerView.addArrangedSubViews(
                awardInfoTitleLabel,
                awardImageView,
                awardInfoSubTitleLabel
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(108)
        }
    }
    
    
    public func setUI(with data: AppAwards) {
        
        clearUI()
        
        guard let awardImageURL = data.awardImageUrl else { return }
        
        // 수상 이미지 설정
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        awardImageView.image = UIImage(systemName: awardImageURL, withConfiguration: imageConfig)  // mock URL
    }
    
    
    private func clearUI() {
        awardImageView.image = nil
    }
}



