//
//  UserRegisterController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/7/24.
//

import UIKit
import SnapKit
import Then
import Alamofire

final class UserRegisterController: UIViewController {
    
    private let contentScrollView = UIScrollView()
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill
    }
    
    private let signUpTitleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "유저 등록",
                                                  color: .white,
                                                  font: UIFont.systemFont(ofSize: 24, weight: .bold))
    }
    
    private let signUpContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill

    }
    
    private let usernameInputTextfield = UITextField().then {
        $0.attributedPlaceholder = .makeAttributedString(text: "이름을 입력해주세요.",
                                                         color: .darkGray,
                                                         font: UIFont.systemFont(ofSize: 16))
        $0.tag = UserInfoInputTextFieldTag.username.rawValue
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    private let passwordInputTextfield = UITextField().then {
        $0.attributedPlaceholder = .makeAttributedString(text: "패스워드를 입력해주세요.",
                                                         color: .darkGray,
                                                         font: UIFont.systemFont(ofSize: 16))
        $0.tag = UserInfoInputTextFieldTag.password.rawValue
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    private let hobbyInputTextfield = UITextField().then {
        $0.attributedPlaceholder = .makeAttributedString(text: "취미를 입력해주세요.",
                                                         color: .darkGray,
                                                         font: UIFont.systemFont(ofSize: 16))
        $0.tag = UserInfoInputTextFieldTag.hobby.rawValue
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    private let signUpButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.setTitle("유저 등록하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private let signUpResponseResultLabel = UILabel()
    
    private var username: String = ""
    private var password: String = ""
    private var hobby: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(Environment.baseURL)
        
        makeUI()
        bindAction()
        setDelegates()
    }
    
    
    private func makeUI() {
        view.backgroundColor = .darkGray
        
        view.addSubViews(
            contentScrollView.addSubViews(
                contentStackView.addArrangedSubViews(
                    signUpContainerStackView.addArrangedSubViews(
                        signUpTitleLabel,
                        usernameInputTextfield,
                        passwordInputTextfield,
                        hobbyInputTextfield,
                        signUpButton,
                        signUpResponseResultLabel
                    ),
                    
                    UIView()
                )
            )
        )
        
        // MARK: 공통
        contentScrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        // MARK: 유저 등록
        
        usernameInputTextfield.snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        passwordInputTextfield.snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        hobbyInputTextfield.snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        // MARK: 유저 로그인
        
        
    }
    
    
    private func setDelegates() {
        usernameInputTextfield.delegate = self
        passwordInputTextfield.delegate = self
        hobbyInputTextfield.delegate = self
    }
    
    
    private func bindAction() {
        signUpButton.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    }
    
    
    @objc private func signUpButtonDidTap() {
        
        guard !username.isEmpty, !password.isEmpty else {
            signUpResponseResultLabel.attributedText = .makeAttributedString(text: "사용자 이름과 비밀번호는 필수 항목입니다.",
                                                                             color: .white,
                                                                             font: UIFont.systemFont(ofSize: 16),
                                                                             textAlignment: .center)
            return
        }
        
        UserService.shared.register(username: username,
                                   password: password,
                                   hobby: hobby) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }

                var text: String
                
                switch result {
                    case .success:
                    text = "회원 등록 성공했어요."
                case let .failure(error):
                    text = error.errorMessage
                }
                
                self.signUpResponseResultLabel.attributedText = .makeAttributedString(text: text,
                                                                                      color: .white,
                                                                                      font: UIFont.systemFont(ofSize: 16),
                                                                                      textAlignment: .center)
            }
        }
    }
}


extension UserRegisterController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let textFieldTag = UserInfoInputTextFieldTag(rawValue: textField.tag)
        
        if let inputText = textField.text {
            switch textFieldTag {
            case .username:
                username = inputText
            case .password:
                password = inputText
            case .hobby:
                hobby = inputText
            default: ()
            }
        }
    }
}


enum Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}


enum UserInfoInputTextFieldTag: Int {
    case username
    case password
    case hobby
}



// MARK: - preview

#if DEBUG
import SwiftUI
struct ServerHomeControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        ServerHomeController()
    }
}

#Preview {
    ServerHomeControllerRepresentable()
}
#endif
