//
//  UserRegisterController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/7/24.
//

import UIKit
import SnapKit
import Then

final class UserRegisterController: UIViewController {
    
    private let containerView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "환영합니다.",
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
    
    private let inputContainerView = UIView()
    
    private let usernameTextField = UITextField().then {
        $0.placeholder = "이름"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.secondarySystemBackground
        $0.configureDefaultSettings()
        $0.setLeftInset(10)
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.secondarySystemBackground
        $0.isSecureTextEntry = true
        $0.configureDefaultSettings()
        $0.setLeftInset(10)
    }
    
    private let hobbyTextField = UITextField().then {
        $0.placeholder = "취미"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.secondarySystemBackground
        $0.configureDefaultSettings()
        $0.setLeftInset(10)
    }
    
    private let registerButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "프로필 생성하기",
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
                inputContainerView.addSubViews(
                    usernameTextField,
                    passwordTextField,
                    hobbyTextField,
                    registerButton
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
        
        inputContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.left.right.bottom.equalToSuperview()
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        hobbyTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(hobbyTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    private func setDelegates() {
//        usernameTextField.delegate = self
//        passwordTextField.delegate = self
//        hobbyTextField.delegate = self
    }
    
    
    private func bindAction() {
        registerButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            registerButtonDidTap()
        }, for: .touchUpInside)
        
        cancelButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
        }, for: .touchUpInside)
    }
    
    
    private func registerButtonDidTap() {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        var hobby = hobbyTextField.text ?? ""
        hobby = !hobby.isEmpty ? hobby : "없음"
        
        guard !username.isEmpty, !password.isEmpty else {
            showAlert(title: "가입 실패", message: "사용자 이름과 비밀번호는 필수 항목입니다.")
            return
        }
        
        UserService.shared.register(username: username,
                                    password: password,
                                    hobby: hobby) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                switch result {
                case .success:
                    dismiss(animated: true)
                case let .failure(error):
                    showAlert(title: "가입 실패", message: error.errorMessage)
                }
            }
        }
    }
}
