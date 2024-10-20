//
//  AppAgeView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class AppAgeView: UIView {
    
    private let containerView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let ageInfoTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "연령",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .light))
    }
    
    private let minimumAgeLabel = UILabel()
    
    private let ageInfoSubTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "세",
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
                ageInfoTitleLabel,
                minimumAgeLabel,
                ageInfoSubTitleLabel
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(108)
        }
    }
    
    
    public func setUI(with data: AppAge) {
        
        clearUI()
        
        guard let minimumAge = data.minAge else { return }
        
        // 최소 연령 레이블 세팅
        minimumAgeLabel.attributedText = .makeAttributedString(text: "\(minimumAge)+",
                                                               color: .gray,
                                                               font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    }
    
    
    private func clearUI() {
        minimumAgeLabel.attributedText = nil
    }
}


