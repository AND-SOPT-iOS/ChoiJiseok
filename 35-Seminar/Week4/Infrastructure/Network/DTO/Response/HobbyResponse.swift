//
//  HobbyResponse.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import Foundation

struct HobbyResponse: Decodable {
    let result: HobbyResult
}

struct HobbyResult: Decodable {
    let hobby: String
}
