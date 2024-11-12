//
//  UserAuthenticator.swift
//  35-Seminar
//
//  Created by 최지석 on 11/9/24.
//

import Foundation
import Alamofire

final class UserAuthenticator: Authenticator {
    
    typealias Credential = UserAuthCredential

    func apply(_ credential: Credential, to urlRequest: inout URLRequest) {
        urlRequest.addValue(credential.accessToken, forHTTPHeaderField: "token")
    }

    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: Credential) -> Bool {
        return true
    }

    func refresh(_ credential: Credential, for session: Session, completion: @escaping (Result<Credential, Error>) -> Void) {
        // TODO: 리프레쉬 API call
        /*
         switch result {
         case .success(let response):
            completion(.success(credential))
         case .failure(let error):
            completion(.failure(error))
         }
         */
    }
}
