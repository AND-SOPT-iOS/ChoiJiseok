//
//  FeedBackDialog.swift
//  35-Seminar
//
//  Created by 최지석 on 10/20/24.
//

import UIKit
import SnapKit
import Then


public class FeedBackDialog {
    
    public static let shared = FeedBackDialog()
    
    private var containerView: UIView?
    
    private var hideTask: Task<Void, Never>? = nil
    
    private init() {}
    
    
    public func show() {
        
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        
        // 기존 Task 취소
        cancelHideTask()
        
        // 기존 컨테이너 뷰 제거
        removeContainerView()
        
        containerView = UIView().then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
            $0.backgroundColor = UIColor.Week2ColorSet.dialogBackgroundGray
            $0.alpha = 0
            $0.isUserInteractionEnabled = false
        }
        
        if let containerView {
            let stackView = UIStackView().then {
                $0.axis = .vertical
                $0.alignment = .center
                $0.spacing = 0
            }
            
            // 별 아이콘
            let starIconImageView = UIImageView().then {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 88, weight: .light)
                $0.image = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
                $0.tintColor = .gray
                $0.contentMode = .scaleAspectFit
            }
            
            // 타이틀 레이블
            let titleLabel = UILabel().then {
                $0.attributedText = .makeAttributedString(text: "제출됨",
                                                          color: .gray,
                                                          font: UIFont.systemFont(ofSize: 26, weight: .medium))
            }
            
            // 설명 레이블
            let descriptionLabel = UILabel().then {
                $0.numberOfLines = 0
                $0.attributedText = .makeAttributedString(text: "피드백을 보내주셔서 감사합니다.",
                                                          color: .gray,
                                                          font: UIFont.systemFont(ofSize: 16, weight: .regular))
            }
            
            window.addSubViews(
                containerView.addSubViews(
                    stackView.addArrangedSubViews(
                        starIconImageView,
                        titleLabel,
                        descriptionLabel
                    )
                )
            )
            
            containerView.snp.makeConstraints {
                $0.size.equalTo(280)
                $0.center.equalToSuperview()
            }
            
            stackView.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(36)
                $0.centerY.equalToSuperview()
            }
            
            stackView.setCustomSpacing(20, after: starIconImageView)
            stackView.setCustomSpacing(6, after: titleLabel)
        }

        // 애니메이션과 함께 다이얼로그 노출
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            containerView?.alpha = 1
        }
        
        // 2초 뒤 다이얼로그 숨김 처리
        hideTask = Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)  // 2초 대기 후 hide
            if !Task.isCancelled {
                hide()
            }
        }
    }
    
    
    private func hide() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self else { return }
                containerView?.alpha = 0
            }, completion: { [weak self] _ in
                guard let self else { return }
                removeContainerView()
            })
        }
    }
    
    
    private func cancelHideTask() {
        hideTask?.cancel()
        hideTask = nil
    }
    
    
    private func removeContainerView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
}

