//
//  UserAuthCredential.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import Foundation
import Alamofire

struct UserAuthCredential: AuthenticationCredential {
    let accessToken: String
    // let refreshToken: String
    let expiredAt: Date

    // 유효시간 5분 이하로 남았다면 refresh가 필요하다고 true를 리턴
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiredAt }
}
