//
//  UINavigationController+Extension.swift
//  35-Seminar
//
//  Created by 최지석 on 10/8/24.
//

import UIKit

extension UINavigationController {
    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}

