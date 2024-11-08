//
//  LoginViewController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin(userName: String)
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "유저이름"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인하기", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        UserService.shared.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let token):
                
                UserDefaults.standard.set(token, forKey: "userToken")

                self?.delegate?.didLogin(userName: username)

                self?.dismiss(animated: true, completion: nil)
                
            case .failure(let error):
                print("로그인 에러: \(error.errorMessage)")
            }
        }
    }
}
