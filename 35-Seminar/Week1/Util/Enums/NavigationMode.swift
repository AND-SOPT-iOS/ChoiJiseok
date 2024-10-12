//
//  NavigationMode.swift
//  35-Seminar
//
//  Created by 최지석 on 10/7/24.
//

@frozen enum NavigationMode: String {
    case push = "push"
    case present = "present"
    
    func toString() -> String {
        return self.rawValue
    }
}
