//
//  Environment.swift
//  35-Seminar
//
//  Created by 최지석 on 11/11/24.
//

import Foundation

enum Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
