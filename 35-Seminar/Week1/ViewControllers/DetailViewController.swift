//
//  DetailViewController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/5/24.
//

import Foundation
import UIKit
import SnapKit
import Then

public protocol DetailViewControllerDelegate: AnyObject {
    func confirmButtonDidTap(password: String?)
}

final class DetailViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let emailLabel = UILabel()
    
    private let passwordTextfield = UITextField().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    private let confirmButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.setTitle("비밀번호 전달 및 돌아가기", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private let backButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.setTitle("이전 화면으로 돌아가기", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private var mail: String?
    private var password: String?
    
    weak var delegate: DetailViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindAction()
    }
    
    
    private func makeUI() {
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        view.addSubview(passwordTextfield)
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }

    private func setDelegates() {
        passwordTextfield.delegate = self
    }
    
    private func bindAction() {
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
    }
    
    
    public func dataBind(email: String?) {

        if let email, !email.isEmpty {
            titleLabel.attributedText = .makeAttributedString(text: "알림 신청이 완료되었어요.",
                                                              color: .white,
                                                              font: UIFont.systemFont(ofSize: 24, weight: .heavy),
                                                              textAlignment: .center)
            emailLabel.attributedText = .makeAttributedString(text: "가입 이메일 : \(email)",
                                                              color: .white,
                                                              font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                              textAlignment: .center)
        } else {
            titleLabel.attributedText = .makeAttributedString(text: "알림 신청을 실패했어요.",
                                                              color: .white,
                                                              font: UIFont.systemFont(ofSize: 24, weight: .heavy),
                                                              textAlignment: .center)
            emailLabel.attributedText = .makeAttributedString(text: "이메일을 다시 입력해주세요.",
                                                              color: .white,
                                                              font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                              textAlignment: .center)
        }
    }
}


// MARK: - Event Handlers
extension DetailViewController {
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
        delegate?.confirmButtonDidTap(password: nil)
    }
    
    @objc private func confirmButtonDidTap() {
        navigationController?.popViewController(animated: true)
        delegate?.confirmButtonDidTap(password: passwordTextfield.text)
    }
}


extension DetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        password = textField.text
    }
}
