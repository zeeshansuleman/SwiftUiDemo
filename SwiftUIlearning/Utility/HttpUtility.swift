//
//  HttpUtility.swift
//  SwiftUIlearning
//
//  Created by Zeeshan Suleman on 11/23/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case noData
    case responseError
    
}

final class HttpUtility {
    static let shared = HttpUtility()
    private init () {}
    
    func postWithCompletion<T: Decodable>(request: URLRequest, resultType: T.Type, completion: @escaping(Result<T,NetworkError>)->Void)
    {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if (error == nil && data != nil) {
                //                let str = String(decoding: data!, as: UTF8.self)
                //                print(str)
                if let decodedData = try? JSONDecoder().decode(resultType, from: data!) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
    
    func postWithAsyncAwais<T: Decodable>(request: URLRequest, resultType: T.Type) async throws -> T {
        do {
            let (data, serverUrlResponse) = try await URLSession.shared.data(for: request)
            guard let statusCode =  (serverUrlResponse as? HTTPURLResponse)?.statusCode, (200 ... 299).contains(statusCode) else {
                throw NetworkError.noData
            }
            let decodedData = try JSONDecoder().decode(resultType, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
//    func postWithCombine<T: Decodable>(request: URLRequest, resultType: T.Type)-> AnyPublisher<T, NetworkError>{
////        return URLSession.shared.dataTaskPublisher(for: request)
////            .tryMap { (data, response) -> Data in
////                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
////                    throw NetworkError.responseError
////                }
////                return data
////            }
////            .decode(type: resultType, decoder: JSONDecoder())
////            .receive(on: RunLoop.main)
////            .eraseToAnyPublisher()
//        
//        
//        
//    }
    static func fetchData<T: Decodable>(from request: URLRequest, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.noData
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.responseError }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
 
}
