//
//  NetworkTestController.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

import UIKit
import SnapKit
import Then
import Alamofire

final class NetworkTestController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Environment.baseURL)
    }
}


enum Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
