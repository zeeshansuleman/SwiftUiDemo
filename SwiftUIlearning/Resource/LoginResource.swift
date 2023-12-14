//
//  LoginResource.swift
//  SwiftUIlearning
//
//  Created by Zeeshan Suleman on 11/22/23.
//

import Foundation

struct LoginResource {
    
    func authenticate(loginRequest: LoginRequest, completion: @escaping(Result<LoginResponse,NetworkError>)->Void) {
        var urlRequest = URLRequest(url: URL(string: Api.baseUrl)!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)
        HttpUtility.shared.postWithCompletion(request: urlRequest, resultType: LoginResponse.self) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
            case .failure(let error):
                print(error)
                completion(.failure(.responseError))

            }
        }
    }
}
