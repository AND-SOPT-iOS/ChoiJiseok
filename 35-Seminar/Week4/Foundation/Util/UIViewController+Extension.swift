//
//  UIViewController+Extension.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import UIKit

extension UIViewController {
    
    // alert 팝업 노출
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true)
    }
}
