//
//  UIView+Extension.swift
//  35-Seminar
//
//  Created by 최지석 on 10/12/24.
//

import UIKit

// MARK: - Add Subviews
extension UIView {
    @discardableResult func addSubViews(_ subviews: UIView...) -> UIView {
        subviews.forEach { [weak self] subview in
            guard let self else { return }
            self.addSubview(subview)
        }
        return self
    }
}

extension UIStackView {
    @discardableResult func addArrangedSubViews(_ subviews: UIView...) -> UIStackView {
        subviews.forEach { [weak self] subview in
            guard let self else { return }
            self.addArrangedSubview(subview)
        }
        return self
    }
    
    @discardableResult func addArrangedSubViews(_ subviews: [UIView]) -> UIStackView {
        subviews.forEach { [weak self] subview in
            guard let self else { return }
            self.addArrangedSubview(subview)
        }
        return self
    }
}



extension UIView {
    /**
     주어진 UIView의 상단에 border를 추가하는 메서드
     
     - Parameters:
       - color: border의 색상을 나타내는 UIColor 객체
       - width: border의 두께를 나타내는 CGFloat 값 (기본값은 1.0)
       - multiplier: border의 길이에 대한 비율 (기본값은 1.0)
     */
    func addTopBorder(color: UIColor = .black, width borderWidth: CGFloat = 1.0, multiplier: CGFloat = 1.0) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        
        addSubview(border)

        border.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(multiplier)
            make.height.equalTo(borderWidth)
            make.top.equalToSuperview()
        }
    }

    /**
     주어진 UIView의 하단에 border를 추가하는 메서드
     
     - Parameters:
       - color: border의 색상을 나타내는 UIColor 객체
       - width: border의 두께를 나타내는 CGFloat 값 (기본값은 1.0)
       - multiplier: border의 길이에 대한 비율을 나타내는 CGFloat 값 (기본값은 1.0)
     */
    func addBottomBorder(color: UIColor = .black, width borderWidth: CGFloat = 1.0, multiplier: CGFloat = 1.0) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        addSubview(border)
        
        border.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(multiplier)
            make.height.equalTo(borderWidth)
            make.bottom.equalToSuperview()
        }
    }

    /**
     주어진 UIView의 좌측에 border를 추가하는 메서드
     
     - Parameters:
       - color: border의 색상을 나타내는 UIColor 객체
       - width: border의 두께를 나타내는 CGFloat 값 (기본값은 1.0)
       - multiplier: border의 길이에 대한 비율을 나타내는 CGFloat 값 (기본값은 1.0)
     */
    func addLeftBorder(color: UIColor = .black, width borderWidth: CGFloat = 1.0, multiplier: CGFloat = 1.0) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        
        addSubview(border)
        
        border.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(multiplier)
            make.width.equalTo(borderWidth)
            make.left.equalToSuperview()
        }
    }

    /**
     주어진 UIView의 우측에 border를 추가하는 메서드
     
     - Parameters:
       - color: border의 색상을 나타내는 UIColor 객체
       - width: border의 두께를 나타내는 CGFloat 값 (기본값은 1.0)
       - multiplier: border의 길이에 대한 비율을 나타내는 CGFloat 값 (기본값은 1.0)
     */
    func addRightBorder(color: UIColor = .black, width borderWidth: CGFloat = 1.0, multiplier: CGFloat = 1.0) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        
        addSubview(border)
        
        border.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(multiplier)
            make.width.equalTo(borderWidth)
            make.right.equalToSuperview()
        }
    }
}
