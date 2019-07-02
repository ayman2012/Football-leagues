//
//  TeamsRepository.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/2/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import RxSwift

class TeamsRepository {
    
    func getLeaguesObserable() -> Observable<[Competition]> {
        return Observable<[Competition]>.create { observer in
            NetworkManager.shared.requestData(endPont: APIClient.leagues, decodingType: LeaguesResponseModel.self) { result in
                switch result {
                case .success(let model):
                    observer.onNext(model.competitions ?? [])
                    DatabaseManager.shared.deleteLeaguesLocalData()
                    DatabaseManager.shared.insertNewLeagues(leagues: model.competitions ?? [])
                    
                case .failure(let err):
                    DatabaseManager.shared.getLocalLeagues { leagues in
                        observer.onNext(leagues)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
