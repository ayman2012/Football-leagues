//
//  LeaguesRepository.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class LeaguesRepository {
    func getLeaguesObserable() -> Observable<[Competition]> {
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.football-data.org/v2/competitions/2006/teams")! as URL)
        request.addValue("2f19619607254006a6f6f26fc4b191fb", forHTTPHeaderField: "X-Auth-Token")
        request.httpMethod = "GET" // or POST or whatever
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response, data, error) in
         print(data)
        }
        return Observable<[Competition]>.create { observer in
            NetworkManager.shared.requestData(endPont: APIClient.teams(ID: "2006"), decodingType: LeaguesResponseModel.self) { result in
                switch result {
                case .success(let model):
                    observer.onNext(model.competitions ?? [])
                     DatabaseManager.shared.deleteLeaguesLocalData()
                    DatabaseManager.shared.insertNewLeagues(leagues: model.competitions ?? [])

                case .failure(let err):
                    DatabaseManager.shared.getLocalLeagues { leagues in
                        observer.onNext(leagues)
                    }
//                    observer.onError(err)
                    //TODO: - getlocal Data
                }
            }
            return Disposables.create()
        }
    }
//    private func getLoaclData()-> Competition{
//        
//    }
}
