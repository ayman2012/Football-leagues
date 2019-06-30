//
//  APIService.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import Moya

enum APIClient {
    case leagues
}
enum Enviroment {
    case production
    case staging
}

//// 2:
extension APIClient: TargetType {
    
    var headers: [String : String]? {
        return  ["Content-Type" : "application/json"]
    }
   
    var enviromentBaseUrl : String {
        switch NetworkManager.enviroment {
        case .production : return "https://api.football-data.org/v2"
        case .staging : return "https://api.football-data.org/v2"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: enviromentBaseUrl)
            else {
                fatalError("baseURL could not be configured")
        }
        return url
//        return URL(string:  "https://jsonplaceholder.typicode.com")!
    }

    // 4:
    var path: String {
        switch self {
        case .leagues  : return "/competitions"
        }
    }
      // 9:
    var task: Task {
        var parameters = [String: Any]()
        switch self  {
        case .leagues:
            return .requestPlain
        }

        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }

    // 5:
    var method: Moya.Method {
        switch self {
        case .leagues:
            return .get
        default:
            return .post
        }
    }

    // 7:
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    // 8:
    var sampleData: Data {
        return Data()
    }


}

