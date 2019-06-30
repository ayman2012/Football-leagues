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
        return Observable<[Competition]>.create { observer in
            NetworkManager.shared.requestData(endPont: APIClient.leagues, decodingType: LeaguesResponseModel.self) { result in
                switch result {
                case .success(let model):
                    observer.onNext(model.competitions ?? [])
                case .failure(let err):
                    observer.onError(err)
                    //TODO: - getlocal Data
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
