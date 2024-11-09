//
//  UserInfoEditController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import UIKit
import SnapKit
import Then

final class UserInfoEditController: UIViewController {
    
    private let containerView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "프로필 수정",
                                                  color: .black,
                                                  font: .systemFont(ofSize: 16, weight: .semibold))
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
    
    private let profileContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let profileThumbnailImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .medium)
        $0.image = UIImage(systemName: "person.crop.circle", withConfiguration: imageConfig)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    private let profileContentsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .center
    }

    private let profileUserNameLabel = UILabel()
    
    private let profileUserEmailLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Testflight@gmail.com",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 12, weight: .regular))
    }
    
    private let inputContainerView = UIView()
    
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
    
    private let editButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "프로필 변경하기",
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
    
    
    public func setUI(name: String) {
        profileUserNameLabel.attributedText = .makeAttributedString(text: name,
                                                                    color: .black,
                                                                    font: UIFont.systemFont(ofSize: 28,
                                                                                            weight: .medium))
    }
    
    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubViews(
            containerView.addSubViews(
                cancelButton,
                titleLabel,
                profileContainerView.addSubViews(
                    profileThumbnailImageView,
                    profileContentsStackView.addArrangedSubViews(
                        profileUserNameLabel,
                        profileUserEmailLabel
                    )
                ),
                inputContainerView.addSubViews(
                    passwordTextField,
                    hobbyTextField,
                    editButton
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
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        // 프로필 영역
        profileContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        profileThumbnailImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        profileContentsStackView.snp.makeConstraints {
            $0.top.equalTo(profileThumbnailImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-32)
        }
        
        // 입력창 영역
        inputContainerView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        hobbyTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        editButton.snp.makeConstraints {
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
        editButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            editButtonDidTap()
        }, for: .touchUpInside)
        
        cancelButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
        }, for: .touchUpInside)
    }
    
    
    private func editButtonDidTap() {
        
        let password = passwordTextField.text ?? ""
        var hobby = hobbyTextField.text ?? ""
        hobby = !hobby.isEmpty ? hobby : "없음"
        
        guard !password.isEmpty else {
            showAlert(title: "변경 실패", message: "비밀번호는 필수 항목입니다.")
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            showAlert(title: "변경 실패", message: "토큰이 만료되었습니다.")
            return
        }
        
        UserService.shared.updateUserInfo(token: token,
                                          hobby: hobby,
                                          password: password) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                switch result {
                    case .success:
                    dismiss(animated: true)
                case let .failure(error):
                    self.showAlert(title: "변경 실패", message: error.errorMessage)
                }
            }
        }
    }
}

