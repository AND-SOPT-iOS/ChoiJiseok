//
//  RegisterRequest.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

struct RegisterRequest: Encodable {
    let username: String
    let password: String
    let hobby: String
}

struct UpdateUserRequest: Encodable {
    let hobby: String
    let password: String
}

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct HobbyResponse: Decodable {
    let result: HobbyResult
}

struct HobbyResult: Decodable {
    let hobby: String
}

struct LoginResponse: Decodable {
    let result: LoginResult
}

struct LoginResult: Decodable {
    let token: String
}

struct ErrorResponse: Decodable {
    let code: String
}
