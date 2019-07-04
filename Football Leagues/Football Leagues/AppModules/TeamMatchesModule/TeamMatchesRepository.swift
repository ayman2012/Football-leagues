//
//  TeamMatchesRepository.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import RxSwift

class TeamMatchesRepository {
    func getLeaguesObserable(competitionId: String) -> Observable<TeamMatchesResponseModel> {
        return Observable<TeamMatchesResponseModel>.create { observer in
            NetworkManager.shared.requestData(endPont: APIClient.team(id: competitionId), decodingType: TeamMatchesResponseModel.self) { result in
                switch result {
                case .success(let model):
                    observer.onNext(model)
//                    DatabaseManager.shared.deleteLeaguesLocalData()
                    //                    DatabaseManager.shared.insertNewLeagues(leagues: model.competitions ?? [])

                case .failure(_):
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
