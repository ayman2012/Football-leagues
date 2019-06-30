//
//  NetworkManager.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import Moya
class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    let provider = MoyaProvider<APIClient>(plugins: [NetworkLoggerPlugin(verbose: true)])
    static let enviroment: Enviroment = .staging
    public enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    func requestData<T: Decodable>(endPont:APIClient, decodingType: T.Type,
                                   completionHandler: @escaping (Result<T>) -> Void) {
        
        provider.request(endPont) { result in
            switch result {
            case .success(let response):
                do{
                    let model: T =  try JSONDecoder().decode(decodingType.self, from: response.data)
                    completionHandler(Result.success(model))
                }
                catch let err{
                    completionHandler(Result.failure(err))
                }
            case .failure(let err):
                completionHandler(Result.failure(err))
            }
        }
    }
}

