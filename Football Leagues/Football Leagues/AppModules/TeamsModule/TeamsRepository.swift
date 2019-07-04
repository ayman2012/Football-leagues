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

    func getTeamsObserable(competitionId: Int) -> Observable<TeamsResponseModel> {
        return Observable<TeamsResponseModel>.create { observer in
            NetworkManager.shared.requestData(endPont: APIClient.teams(id: "\(competitionId)"), decodingType: TeamsResponseModel.self) { result in
                switch result {
                case .success(let model):
                    observer.onNext(model)
                    DatabaseManager.shared.saveTeamsData(team: model, leagueid: competitionId)
                case .failure(_):
                    DatabaseManager.shared.getTeamsData(leagueid: competitionId) { leagues in
                        observer.onNext(leagues)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
