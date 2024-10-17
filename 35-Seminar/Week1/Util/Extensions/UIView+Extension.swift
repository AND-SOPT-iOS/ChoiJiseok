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
}

