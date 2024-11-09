//
//  UserLoginController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import SnapKit
import Then

protocol UserLoginControllerDelegate: AnyObject {
    func didLogin(username: String)
}

class UserLoginController: UIViewController {
    
    weak var delegate: UserLoginControllerDelegate?
    
    private let containerView = UIView()
    
    private let cancelButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "취소",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .regular)))
        config.contentInsets = .zero
        $0.configuration = config
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Apple 계정 암호",
                                                  color: .black,
                                                  font: .systemFont(ofSize: 30, weight: .bold))
    }
    
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
    
    private let loginButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "로그인",
                                                                        color: .systemBlue,
                                                                        font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .regular)))
        $0.configuration = config
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindAction()
    }
    
    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubViews(
            containerView.addSubViews(
                cancelButton,
                titleLabel,
                usernameTextField,
                passwordTextField,
                loginButton
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
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }

    
    private func bindAction() {
        loginButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            loginButtonDidTap()
        }, for: .touchUpInside)
        
        cancelButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            cancelButtonDidTap()
        }, for: .touchUpInside)
    }
    
    
    private func loginButtonDidTap() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else { return }
        
        UserService.shared.login(username: username, 
                                 password: password) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let token):

                // 토큰 저장
                TokenManager.shared.setAccessToken(token)

                delegate?.didLogin(username: username)

                dismiss(animated: true)
            case .failure(let error):
                showAlert(title: "로그인 실패", message: error.errorMessage)
            }
        }
    }
    
    
    private func cancelButtonDidTap() {
        dismiss(animated: true)
    }
}
