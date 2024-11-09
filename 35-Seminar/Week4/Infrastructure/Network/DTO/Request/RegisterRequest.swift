//
//  RegisterRequest.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import Foundation

struct RegisterRequest: Encodable {
    let username: String
    let password: String
    let hobby: String
}
