//
//  UserHobbyLookUpController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import SnapKit

class UserHobbyLookUpController: UIViewController {
    
    private let containerView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "취미 조회",
                                                  color: .black,
                                                  font: .systemFont(ofSize: 30, weight: .bold))
    }
    
    private let cancelButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "취소",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .regular)))
        config.contentInsets = .zero
        $0.configuration = config
    }

    private let hobbyContainerView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
    
    private let hobbyLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    private let inputContainerView = UIView()
    
    private let userIdTextField = UITextField().then {
        $0.placeholder = "사용자 ID"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.secondarySystemBackground
        $0.configureDefaultSettings()
        $0.setLeftInset(10)
    }
    
    private let lookUpButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "조회하기",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .regular)))
        $0.configuration = config
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindAction()
        setDelegates()
    }
    
    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubViews(
            containerView.addSubViews(
                cancelButton,
                titleLabel,
                hobbyContainerView.addSubViews(
                    hobbyLabel
                ),
                inputContainerView.addSubViews(
                    userIdTextField,
                    lookUpButton
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(56)
            $0.centerX.equalToSuperview()
        }
        
        hobbyContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(44)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        hobbyLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(20)
        }
        
        inputContainerView.snp.makeConstraints {
            $0.top.equalTo(hobbyContainerView.snp.bottom).offset(12)
            $0.left.right.bottom.equalToSuperview()
        }
        
        userIdTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        lookUpButton.snp.makeConstraints {
            $0.top.equalTo(userIdTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    private func setDelegates() {
        userIdTextField.delegate = self
    }
    
    
    private func bindAction() {
        lookUpButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            lookupButtonDidTap()
        }, for: .touchUpInside)
        
        cancelButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
        }, for: .touchUpInside)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    
    private func lookupButtonDidTap() {
        guard let userId = userIdTextField.text, !userId.isEmpty else {
            showAlert(title: "조회 실패", message: "올바른 ID를 입력해주세요.")
            return
        }
        
        UserService.shared.getOtherUserHobby(userId: userId) { [weak self] result in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                switch result {
                case .success(let hobby):
                    hobbyLabel.attributedText = .makeAttributedString(text: hobby,
                                                                      color: .black,
                                                                      font: UIFont.systemFont(ofSize: 16, weight: .regular))
                case .failure(let error):
                    showAlert(title: "조회 실패", message: error.errorMessage)
                }
            }
        }
    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UserHobbyLookUpController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hobbyLabel.attributedText = nil
    }
}
