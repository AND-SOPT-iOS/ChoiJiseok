//
//  AppstoreEntryPointController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

import Foundation
import UIKit
import SnapKit
import Then

final class AppstoreEntryPointController: UIViewController {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let appstoreIconImageView = UIImageView().then {
        $0.image = UIImage(named: "appstore_icon")
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
    
    private let appstoreTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "앱스토어로 이동하기",
                                                  color: .black,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .bold))
    }
    
    private let appstoreDescriptionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "세상의 모든 금융, 역시 앱스토어에서.",
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
            containerView.addSubViews(
                // 토스 이미지
                appstoreIconImageView,
                // 레이블 컨테이너 스택
                labelContainerStackView.addArrangedSubViews(
                    appstoreTitleLabel,
                    appstoreDescriptionLabel
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        appstoreIconImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        labelContainerStackView.snp.makeConstraints {
            $0.left.equalTo(appstoreIconImageView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    
    private func bindAction() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(appstoreContainerViewDidTap))
        containerView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc private func appstoreContainerViewDidTap() {
        let financeCategoryController = AppstoreFinanceCategoryController()
        navigationController?.pushViewController(financeCategoryController, animated: true)
        navigationItem.backButtonTitle = "앱"
    }
}


