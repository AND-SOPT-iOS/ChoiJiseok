//
//  TokenManager.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import Foundation
import Security

final class TokenManager {
    
    public static let shared = TokenManager()
    
    private init() {}
    
    
    // 신규 유저 여부
    /// 디바이스에서 어플리케이션을 제거 후 다시 설치하는 경우, KeyChain에 저장되어 있던 토큰 제거 필요
    var isNewUser: Bool {
        get {
            return UserDefaults.standard.value(forKey: Const.isNewUser) as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Const.isNewUser)
        }
    }
     
    
    // 토큰 저장
    func setAccessToken(_ token: String) {
        
        guard let data = token.data(using: .utf8) else { return }
        
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Const.accessTokenKey,
            kSecValueData as String: data
        ] as CFDictionary
        
        SecItemDelete(query)  // Keychain은 Key 중복이 발생하면, 저장할 수 없기 때문에 먼저 Delete

        let status = SecItemAdd(query, nil)
        assert(status == noErr, "Access Token 저장 실패")
    }
    
    
    // 토큰 조회
    func getAccessToken() -> String? {
        
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Const.accessTokenKey,
            kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러옴
            kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러옴
        ] as CFDictionary
        
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == noErr {
            if let retrievedData = dataTypeRef as? Data,
               let token = String(data: retrievedData, encoding: .utf8) {
                return token
            }
        }
        return nil
    }
    
    
    // 토큰 제거
    func clearTokens() {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Const.accessTokenKey
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
