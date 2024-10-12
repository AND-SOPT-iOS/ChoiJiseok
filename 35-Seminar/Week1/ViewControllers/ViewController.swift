//
//  ViewController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/5/24.
//

import UIKit
import Then
import RegexBuilder

class ViewController: UIViewController {
    
    // 화면 전환 모드
    private var navigationMode: NavigationMode = .push {
        willSet(mode) {
            currentModeLabel.attributedText = .makeAttributedString(text: "현재 모드 : \(mode.toString())",
                                                                    color: .white,
                                                                    font: .systemFont(ofSize: 12))
        }
    }
    
    private var isLayoutAdjustedForKeyboardAppearance: Bool = false  // 키보드에 의한 UI 레이아웃 변경 여부
    
    
    private let currentModeLabel = UILabel()
    
    private let passwordLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "전달된 비밀번호 없음",
                                                  color: .white,
                                                  font: UIFont.boldSystemFont(ofSize: 12))
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "sopt_icon")
        $0.contentMode = .scaleAspectFit
    }
    
    private let contentsLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.attributedText = .makeAttributedString(text: "지금은 모집 기간이 아니에요.\n 모집 기간이 되면 메일로 알려드릴게요.",
                                                  color: .white,
                                                  font: UIFont.systemFont(ofSize: 18, weight: .heavy),
                                                  textAlignment: .center,
                                                  lineBreakMode: .byWordWrapping,
                                                  lineBreakStrategy: .hangulWordPriority,
                                                  lineHeightMultiple: 1.4)
    }
    
    private let emailInputContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let emailInputTextfieldContainerView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    private let emailErrorLabel = UILabel().then {
        $0.isHidden = true
    }
    
    private let applyButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.setTitle("알림 신청하기", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private let emailTextfield = UITextField().then {
        $0.attributedPlaceholder = .makeAttributedString(text: "메일을 입력해주세요.",
                                                         color: .white,
                                                         font: UIFont.systemFont(ofSize: 16))
        $0.textColor = .white
        $0.tintColor = .white
        $0.backgroundColor = .clear
    }
    
    private let modeSwitch = UISwitch().then {
        $0.onTintColor = .systemBlue
        $0.isEnabled = true
        $0.isOn = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindAction()
        setDelegates()
        setObservers()
    }
    
    
    private func makeUI() {
        view.backgroundColor = .Week1ColorSet.backgroundColor
        
        view.addSubview(currentModeLabel)
        currentModeLabel.attributedText = .makeAttributedString(text: "현재 모드 : \(navigationMode.toString())",
                                                                color: .white,
                                                                font: .systemFont(ofSize: 12))
        currentModeLabel.frame = CGRect(x: 20,
                                        y: 90,
                                        width: 100,
                                        height: 30)
        view.addSubview(passwordLabel)
        passwordLabel.frame = CGRect(x: 20,
                                     y: 130,
                                     width: 200,
                                     height: 30)
        
        view.addSubview(modeSwitch)
        modeSwitch.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 70,
                                          y: 90)
        
        view.addSubview(logoImageView)
        logoImageView.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100,
                                     y: UIScreen.main.bounds.height / 2 - 150,
                                     width: 200,
                                     height: 100)
        
        view.addSubview(contentsLabel)
        contentsLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 175,
                                     y: UIScreen.main.bounds.height / 2 - 100,
                                     width: 350,
                                     height: 200)
        
        view.addSubview(emailInputContainerView)
        emailInputContainerView.frame = CGRect(x: 0,
                                               y: UIScreen.main.bounds.height / 2 + 200 ,
                                               width: UIScreen.main.bounds.width,
                                               height: 90)
        
        emailInputContainerView.addSubview(emailInputTextfieldContainerView)
        emailInputTextfieldContainerView.frame = CGRect(x: 20,
                                                        y: 30,
                                                        width: emailInputContainerView.frame.width - 40,
                                                        height: 60)
        
        emailInputContainerView.addSubview(emailErrorLabel)
        emailErrorLabel.frame = CGRect(x: 30,
                                       y: 0,
                                       width: 200,
                                       height: 30)
        
        emailInputTextfieldContainerView.addSubview(applyButton)
        applyButton.frame = CGRect(x: emailInputTextfieldContainerView.frame.width - 125,
                                   y: 5,
                                   width: 120,
                                   height: 50)
        
        emailInputTextfieldContainerView.addSubview(emailTextfield)
        emailTextfield.frame = CGRect(x: 15,
                                      y: 10,
                                      width: Int(emailInputTextfieldContainerView.frame.width - 150.0),
                                      height: 40)
    }
    
    
    private func bindAction() {
        applyButton.addTarget(self, action: #selector(applyButtonDidTap), for: .touchUpInside)
        modeSwitch.addTarget(self, action: #selector(toggleSwitch(sender:)), for: .touchUpInside)
    }
    
    
    private func setDelegates() {
        emailTextfield.delegate = self
    }
    
    
    private func setObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}


extension ViewController {
    
    private func isEmailNotEmpty(email: String) -> Bool {
        return !email.isEmpty
    }
    
    
    private func isEmailValid(email: String) -> Bool {
        // 이메일 정규식
        let emailRegex = Regex {
            OneOrMore { CharacterClass(.word, .anyOf(".+_%+-")) }
            "@"
            OneOrMore { CharacterClass(.word) }
            "."
            Repeat(2...64) { CharacterClass("a"..."z") }
        }
        
        guard email.wholeMatch(of: emailRegex) != nil else { return false }
        
        return true
    }
    
    
    private func adjustLayoutForKeyboardAppearance(with keyboardHeight: CGFloat) {
        isLayoutAdjustedForKeyboardAppearance = true
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else { return }
            // 키보드 바로 위에 이메일 입력 컨테이너 뷰를 붙여줌
            emailInputContainerView.frame = CGRect(x: 0,
                                                   y: UIScreen.main.bounds.height - (keyboardHeight + emailInputContainerView.frame.height),
                                                   width: UIScreen.main.bounds.width,
                                                   height: 90)
            
            // 텍스트 필드 컨테이너 뷰 좌우 확장
            emailInputTextfieldContainerView.frame = CGRect(x: 0,
                                                            y: 30,
                                                            width: emailInputContainerView.frame.width,
                                                            height: 60)
            emailInputTextfieldContainerView.layer.cornerRadius = 0
            
            // 지원 버튼 모양 수정 및 컨테이너 뷰 오른쪽에 붙임
            applyButton.frame = CGRect(x: emailInputTextfieldContainerView.frame.width - 125,
                                       y: 5,
                                       width: 120,
                                       height: 50)
            applyButton.layer.cornerRadius = 5
            
            // 로고 이미지, 레이블은 40px씩만 위로 올려줌
            emailErrorLabel.transform = CGAffineTransform(translationX: -20, y: 0)
            logoImageView.transform = CGAffineTransform(translationX: 0, y: -40)
            contentsLabel.transform = CGAffineTransform(translationX: 0, y: -40)
        })
    }
    
    
    private func restoreOriginalLayout() {
        isLayoutAdjustedForKeyboardAppearance = false
        
        // 원래 레이아웃으로 복구
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else { return }
            
            emailInputContainerView.frame = CGRect(x: 0,
                                                   y: UIScreen.main.bounds.height / 2 + 200 ,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 90)
            
            emailInputTextfieldContainerView.frame = CGRect(x: 20,
                                                            y: 30,
                                                            width: emailInputContainerView.frame.width - 40,
                                                            height: 60)
            emailInputTextfieldContainerView.layer.cornerRadius = 30
            
            applyButton.frame = CGRect(x: emailInputTextfieldContainerView.frame.width - 125,
                                       y: 5,
                                       width: 120,
                                       height: 50)
            applyButton.layer.cornerRadius = 25
            
            emailErrorLabel.transform = .identity
            logoImageView.transform = .identity
            contentsLabel.transform = .identity
        })
    }
    
    
    private func resetUI() {
        if isLayoutAdjustedForKeyboardAppearance == true {
            restoreOriginalLayout()
        }
        emailErrorLabel.isHidden = true
        emailErrorLabel.attributedText = nil
        emailTextfield.text = nil
    }
}


// MARK: - Event Handlers
extension ViewController {

    @objc private func applyButtonDidTap() {
        let email: String = emailTextfield.text ?? ""
        
        // (1) 이메일 존재 여부 체크
        guard isEmailNotEmpty(email: email) else {
            emailErrorLabel.attributedText = .makeAttributedString(text: "이메일을 입력해주세요.",
                                                                   color: .Week1ColorSet.errorMessageColor,
                                                                   font: UIFont.systemFont(ofSize: 14, weight: .medium))
            emailErrorLabel.isHidden = false
            return
        }
        
        // (2) 이메일 유효성 체크
        guard isEmailValid(email: email) else {
            emailErrorLabel.attributedText = .makeAttributedString(text: "유효한 이메일을 입력해주세요.",
                                                                   color: .Week1ColorSet.errorMessageColor,
                                                                   font: UIFont.systemFont(ofSize: 14, weight: .medium))
            emailErrorLabel.isHidden = false
            return
        }
        
        // 키보드 내림
        view.endEditing(true)
        
        // 데이터 전달 및 내비게이션 수행
        switch navigationMode {
        case .push:
            let detailViewController = DetailViewController()
            detailViewController.delegate = self
            detailViewController.dataBind(email: email)
            
            navigationController?.pushViewController(detailViewController, animated: true, completion: { [weak self] in
                guard let self else { return }
                resetUI()
            })
        case .present:
            let modalViewController = ModalViewController()
            modalViewController.dataBind(email: email)
            
            navigationController?.present(UINavigationController(rootViewController: modalViewController), animated: true, completion: { [weak self] in
                guard let self else { return }
                resetUI()
            })
        }
        
        func address(of object: UnsafeRawPointer) -> String {
            let addr = Int(bitPattern: object)
            return String(format: "%p", addr)
        }
        
        struct A {
            var a: Int = 0
            let b: Int = 0
        }
        
        var a = A()
        print(a)
        a.a = 0
        print(a)
    }
    
    
    @objc private func toggleSwitch(sender: UISwitch) {
        navigationMode = sender.isOn ? .push : .present
    }
    
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            adjustLayoutForKeyboardAppearance(with: keyboardFrame.height)
        }
    }

    
    @objc private func keyboardWillHide(_ notification: Notification) {
        restoreOriginalLayout()
    }
}


// MARK: - Delegates
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        emailErrorLabel.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension ViewController: DetailViewControllerDelegate {
    func confirmButtonDidTap(password: String?) {
        if let password, !password.isEmpty {
            passwordLabel.attributedText = .makeAttributedString(text: password,
                                                                 color: .white,
                                                                 font: UIFont.systemFont(ofSize: 12))
        } else {
            passwordLabel.attributedText = .makeAttributedString(text: "전달된 비밀번호 없음",
                                                                 color: .white,
                                                                 font: UIFont.systemFont(ofSize: 12))
        }
    }
}
