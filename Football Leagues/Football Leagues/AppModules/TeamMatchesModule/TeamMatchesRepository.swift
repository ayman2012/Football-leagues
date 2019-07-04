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
    func getLeaguesObserable(competitionId: Int) -> Observable<TeamMatchesResponseModel> {
        return Observable<TeamMatchesResponseModel>.create { observer in
            NetworkManager.shared.requestData(endPont: APIClient.team(id: "\(competitionId)"), decodingType: TeamMatchesResponseModel.self) { result in
                switch result {
                case .success(let model):
                    observer.onNext(model)
                    DatabaseManager.shared.saveMatchesData(team:model, leagueid: competitionId)
                case .failure(_):
                    DatabaseManager.shared.getMatchesData(leagueid: competitionId) { leagues in
                        observer.onNext(TeamMatchesResponseModel.init(count: 0, filters: nil, matches: leagues))
                    }
                }
            }
            return Disposables.create()
        }
    }
}
