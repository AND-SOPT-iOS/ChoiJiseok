//
//  MyHobbyViewController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/8/24.
//

import UIKit
import SnapKit
import Then

class MyHobbyViewController: UIViewController {
    
    private let hobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "내 취미: 없음"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let fetchHobbyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("내 취미 조회", for: .normal)
        button.addTarget(self, action: #selector(fetchHobbyTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(hobbyLabel)
        view.addSubview(fetchHobbyButton)
        
        hobbyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        fetchHobbyButton.snp.makeConstraints {
            $0.top.equalTo(hobbyLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func fetchHobbyTapped() {
        guard let token = UserDefaults.standard.string(forKey: "userToken") else { return }
        
        UserService.shared.getMyHobby(token: token) { [weak self] result in
            switch result {
            case .success(let hobby):
                self?.hobbyLabel.text = "내 취미: \(hobby)"
            case .failure(let error):
                self?.hobbyLabel.text = "에러: \(error.errorMessage)"
            }
        }
    }
}

