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
    
    func getLeaguesObserable(competitionId:String) -> Observable<TeamsResponseModel> {
        return Observable<TeamsResponseModel>.create { observer in
            NetworkManager.shared.requestData(endPont: APIClient.teams(id: competitionId), decodingType: TeamsResponseModel.self) { result in
                switch result {
                case .success(let model):
                    observer.onNext(model)
                    DatabaseManager.shared.deleteLeaguesLocalData()
//                    DatabaseManager.shared.insertNewLeagues(leagues: model.competitions ?? [])
                    
                case .failure(let err):
                    break
//                    DatabaseManager.shared.getLocalLeagues { leagues in
//                        observer.onNext(leagues)
//                    }
                }
            }
            return Disposables.create()
        }
    }
}
