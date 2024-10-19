//
//  AppCompatibleDevicesView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit

class AppCompatibleDevicesView: UIView {
    
    private let containerView = UIView()
    
    private let compatibleDevicesContainerView = UIView().then {
        $0.addBottomBorder(color: .lightGray, width: 1)
    }
    
    private let compatibleDeviceIconImagesStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let compatibleDeviceIconImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        $0.image = UIImage(systemName: "iphone", withConfiguration: imageConfig)
        $0.tintColor = .lightGray
        $0.contentMode = .scaleAspectFit
    }
    
    private let compatibleDeviceNameLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "iPhone",
                                                  color: .gray,
                                                  font: UIFont.systemFont(ofSize: 14, weight: .medium))
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        
        addSubview(
            containerView.addSubViews(
                compatibleDevicesContainerView.addSubViews(
                    compatibleDeviceIconImagesStackView.addArrangedSubViews(
                        compatibleDeviceIconImageView
                    ),
                    compatibleDeviceNameLabel
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        compatibleDevicesContainerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
        
        compatibleDeviceIconImagesStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        compatibleDeviceIconImageView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        compatibleDeviceNameLabel.snp.makeConstraints {
            $0.left.equalTo(compatibleDeviceIconImagesStackView.snp.right).offset(10)
            $0.centerY.equalTo(compatibleDeviceIconImageView.snp.centerY)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
    }

}
