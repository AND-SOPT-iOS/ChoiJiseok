//
//  AppstoreMainController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/12/24.
//

import Foundation
import UIKit
import SnapKit
import Then

final class AppstoreMainController: UIViewController {
    
    private let tossContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let tossIconImageView = UIImageView().then {
        $0.image = UIImage(named: "toss_icon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Week2ColorSet.logoImageBorderColor.cgColor
    }
    
    private let labelContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    private let tossTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "토스",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .bold))
    }
    
    private let tossDescriptionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "금융이 쉬워진다.",
                                                  color: .lightGray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .medium))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindAction()
    }
    
    private func makeUI() {
        view.backgroundColor = .black
        
        view.addSubViews(
            tossContainerView.addSubViews(
                // 토스 이미지
                tossIconImageView,
                // 레이블 컨테이너 스택
                labelContainerStackView.addArrangedSubViews(
                    tossTitleLabel,
                    tossDescriptionLabel
                )
            )
        )
        
        tossContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        tossIconImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        labelContainerStackView.snp.makeConstraints {
            $0.left.equalTo(tossIconImageView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    
    private func bindAction() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(tossContainerViewDidTap))
        tossContainerView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc private func tossContainerViewDidTap() {
        let appstoreDetailController = AppstoreDetailController()
        navigationController?.pushViewController(appstoreDetailController, animated: true)
        navigationItem.backButtonTitle = "검색"
    }
}

