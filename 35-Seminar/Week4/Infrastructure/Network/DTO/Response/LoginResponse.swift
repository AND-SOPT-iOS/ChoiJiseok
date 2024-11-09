//
//  LoginResponse.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import Foundation

struct LoginResponse: Decodable {
    let result: LoginResult
}

struct LoginResult: Decodable {
    let token: String
}
