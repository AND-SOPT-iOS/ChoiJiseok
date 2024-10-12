//
//  AppstoreMainController.swift
//  35-Seminar
//
//  Created by 최지석 on 10/12/24.
//

import Foundation
import UIKit
import SnapKit
import Then

final class AppstoreMainController: UIViewController {
    
    private let tossIconImageView = UIImageView().then {
        $0.image = UIImage(named: "toss_icon")
        $0.contentMode = .scaleAspectFit
    }
    
    private let tossContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func makeUI() {
        view.backgroundColor = .black
    }
}

