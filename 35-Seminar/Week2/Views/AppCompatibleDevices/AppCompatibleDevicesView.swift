//
//  AppCompatibleDevicesView.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import UIKit

final class AppCompatibleDevicesView: UIView {
    
    private let containerView = UIView()
    
    private let compatibleDevicesContainerView = UIView().then {
        $0.addBottomBorder(color: .lightGray, width: 1)
    }
    
    private let compatibleDeviceIconImagesStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let compatibleDeviceNameLabel = UILabel()
    
    
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
                    compatibleDeviceIconImagesStackView,
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
        
        
        
        compatibleDeviceNameLabel.snp.makeConstraints {
            $0.left.equalTo(compatibleDeviceIconImagesStackView.snp.right).offset(10)
            $0.centerY.equalTo(compatibleDeviceIconImagesStackView.snp.centerY)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
    }
    
    
    public func setUI(with data: CompatibleDevices) {
        
        clearUI()
        
        guard let deviceIcons = data.deviceIcons, !deviceIcons.isEmpty,
              let deviceNames = data.deviceNames, !deviceNames.isEmpty else { return }
        
        
        // 디바이스 아이콘 세팅
        for deviceIcon in deviceIcons {
            let compatibleDeviceIconImageView = UIImageView().then {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
                $0.image = UIImage(systemName: deviceIcon, withConfiguration: imageConfig)
                $0.tintColor = .lightGray
                $0.contentMode = .scaleAspectFit
            }
            
            compatibleDeviceIconImageView.snp.makeConstraints {
                $0.size.equalTo(20)
            }
            
            compatibleDeviceIconImagesStackView.addArrangedSubview(compatibleDeviceIconImageView)
        }
        
        // 디바이스 이름 레이블 세팅
        var deviceNamesString = ""
        
        for (index, deviceName) in deviceNames.enumerated() {
            // 마지막 디바이스가 아닌 경우
            if index < deviceNames.count - 1 {
                deviceNamesString.append(deviceName)
                deviceNamesString.append(",  ")
            }
            // 마지막 디바이스인 경우
            else {
                deviceNamesString.append(deviceName)
            }
        }
        
        compatibleDeviceNameLabel.attributedText = .makeAttributedString(text: deviceNamesString,
                                                                         color: .gray,
                                                                         font: UIFont.systemFont(ofSize: 14, weight: .medium))
    }
    
    
    private func clearUI() {
        for subview in compatibleDeviceIconImagesStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        compatibleDeviceNameLabel.attributedText = nil
    }
}
