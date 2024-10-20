//
//  AppShortInfoView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class AppShortInfoSwipeView: UIView {
    
    private let containerView = UIView()
    
    private let horizonalSwipeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.addTopBorder(color: UIColor.Week2ColorSet.borderGray, width: 1)
        $0.addBottomBorder(color: UIColor.Week2ColorSet.borderGray, width: 1)
    }
    
    private let appRatingView = AppRatingView()
    
    private let appAwardView = AppAwardView()
    
    private let appAgeView = AppAgeView()
    
    
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
                horizonalSwipeStackView
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        horizonalSwipeStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.height.equalToSuperview()
        }
    }
    
    
    public func setUI(with data: AppShortInfo) {
        
        clearUI()
        
        // 평가 뷰
        if let appEvaluation =  data.evaluation {
            horizonalSwipeStackView.addArrangedSubview(appRatingView)
            appRatingView.setUI(with: appEvaluation)
        }
        // 수상 뷰
        if let appAward = data.awards {
            horizonalSwipeStackView.addArrangedSubview(appAwardView)
            appAwardView.setUI(with: appAward)
        }
        // 최소 연령 뷰
        if let appAge = data.age {
            horizonalSwipeStackView.addArrangedSubview(appAgeView)
            appAgeView.setUI(with: appAge)
        }
        
        // 스택 뷰의 하위 뷰 사이사이에 divider 추가
        for i in 0..<(horizonalSwipeStackView.arrangedSubviews.count - 1) {
            let spacerView = UIView().then {
                $0.backgroundColor = UIColor.Week2ColorSet.borderGray
            }
            
            spacerView.snp.makeConstraints {
                $0.width.equalTo(1)
                $0.height.equalTo(40)
            }
            
            horizonalSwipeStackView.insertArrangedSubview(spacerView, at: (2 * i + 1))
        }
    }
            
            
    private func clearUI() {
        for subview in horizonalSwipeStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
