//
//  UserService.swift
//  35-Seminar
//
//  Created by 최지석 on 11/2/24.
//

import Alamofire
import Foundation

public class UserService {
    
    static let shared = UserService()
    
    private init() { }

    // 1. 사용자 등록
    func register(username: String,
                  password: String,
                  hobby: String,
                  completion: @escaping (Result<Bool, NetworkError>) -> Void) {

        let url = Environment.baseURL + "/user"

        let parameters = RegisterRequest(username: username,
                                         password: password,
                                         hobby: hobby)
          
        AF.request(url, 
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data,
                      let self else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure:
                    let error = self.handleStatusCode(statusCode, data: data)
                    completion(.failure(error))
                }
            }
    }

    // 2. 사용자 취미 조회
    func getMyHobby(completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        let url = Environment.baseURL + "/user/my-hobby"
        
        let authenticator = UserAuthenticator()
        let credential = UserAuthCredential(accessToken: TokenManager.shared.getAccessToken() ?? "",
                                            expiredAt: Date(timeIntervalSinceNow: 60 * 120))
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        
        AF.request(url,
                   method: .get, 
                   interceptor: interceptor)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data,
                      let self else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                    do {
                        let hobby = try JSONDecoder().decode(HobbyResponse.self, from: data).result.hobby
                        completion(.success(hobby))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                case .failure:
                    let networkError = self.handleStatusCode(statusCode, data: data)
                    completion(.failure(networkError))
                }
            }
    }

    // 3. 다른 사용자 취미 조회
    func getOtherUserHobby(userId: String,
                           completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        let url = Environment.baseURL + "/user/\(userId)/hobby"
        
        let authenticator = UserAuthenticator()
        let credential = UserAuthCredential(accessToken: TokenManager.shared.getAccessToken() ?? "",
                                            expiredAt: Date(timeIntervalSinceNow: 60 * 120))
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        
        AF.request(url, 
                   method: .get,
                   interceptor: interceptor)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data,
                      let self else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                    do {
                        let hobby = try JSONDecoder().decode(HobbyResponse.self, from: data).result.hobby
                        completion(.success(hobby))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                case .failure:
                    let networkError = self.handleStatusCode(statusCode, data: data)
                    completion(.failure(networkError))
                }
            }
    }

    // 4. 유저 정보 변경
    func updateUserInfo(hobby: String,
                        password: String,
                        completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        
        let url = Environment.baseURL + "/user"
        
        let authenticator = UserAuthenticator()
        let credential = UserAuthCredential(accessToken: TokenManager.shared.getAccessToken() ?? "",
                                            expiredAt: Date(timeIntervalSinceNow: 60 * 120))
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        
        let parameters = UserInfoEditRequest(hobby: hobby, password: password)
        
        AF.request(url,
                   method: .put,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   interceptor: interceptor)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let self else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure:
                    let networkError = self.handleStatusCode(statusCode, data: Data())
                    print(networkError.errorMessage)
                    completion(.failure(networkError))
                }
            }
    }

    // 5. 사용자 로그인
    func login(username: String,
               password: String,
               completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        let url = Environment.baseURL + "/login"
        
        let parameters = LoginRequest(username: username, password: password)
        
        AF.request(url, 
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data,
                      let self else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                    do {
                        let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        let token = decodedResponse.result.token
                        completion(.success(token))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                case .failure:
                    let networkError = self.handleStatusCode(statusCode, data: data)
                    completion(.failure(networkError))
                }
            }
    }

    
    func handleStatusCode(_ statusCode: Int,
                          data: Data) -> NetworkError {
        
        let errorCode = decodeError(data: data)
        
        switch (statusCode, errorCode) {
        case (400, "00"):
            return .invalidRequest
        case (400, "01"):
            return .expressionError
        case (404, ""):
            return .invalidURL
        case (409, "00"):
            return .duplicateError
        case (500, ""):
            return .serverError
        default:
            return .unknownError
        }
    }

    private func decodeError(data: Data) -> String {
        guard let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
            return ""
        }
        return errorResponse.code
    }
}


enum Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
