//
//  AppstoreVersionHistoryController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/20/24.
//

import UIKit
import SnapKit
import Then


final class AppstoreVersionHistoryController: UIViewController {
    
    private let versionHistoryTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "버전 기록",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 36, weight: .bold))
        $0.addBottomBorder(color: UIColor.Week2ColorSet.borderGray)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }

    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubViews(
            versionHistoryTitleLabel
        )
        
        versionHistoryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(60)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
}
