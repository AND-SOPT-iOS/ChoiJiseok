//
//  OtherUserHobbyViewController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import SnapKit

class OtherUserHobbyViewController: UIViewController {
    
    private let userIdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "사용자 ID 입력"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let hobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 사람의 취미: 없음"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let fetchHobbyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취미 조회", for: .normal)
        button.addTarget(self, action: #selector(fetchHobbyTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(userIdTextField)
        view.addSubview(hobbyLabel)
        view.addSubview(fetchHobbyButton)
        
        userIdTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        hobbyLabel.snp.makeConstraints {
            $0.top.equalTo(userIdTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        fetchHobbyButton.snp.makeConstraints {
            $0.top.equalTo(hobbyLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func fetchHobbyTapped() {
        guard let userId = userIdTextField.text, !userId.isEmpty else {
            hobbyLabel.text = "사용자 ID를 입력해주세요."
            return
        }
        
        UserService.shared.getOtherUserHobby(userId: userId) { [weak self] result in
            switch result {
            case .success(let hobby):
                self?.hobbyLabel.text = "다른 사람의 취미: \(hobby)"
            case .failure(let error):
                self?.hobbyLabel.text = "에러: \(error.errorMessage)"
            }
        }
    }
}

