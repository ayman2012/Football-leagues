//
//  TeamMatchesViewModel.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TeamMatchesViewModel {
    let loadingSubject = PublishRelay<Bool>()
    var teamsMatches = BehaviorRelay<TeamMatchesResponseModel?>(value: nil)
    var disposeBag = DisposeBag()
    private let teamsMatchesRepository: TeamMatchesRepository!

    init(repository: TeamMatchesRepository) {
        self.teamsMatchesRepository = repository
    }
    func configerBinding(Id: String) {
        teamsMatchesRepository.getLeaguesObserable(competitionId: Id).bind(to: teamsMatches)
        teamsMatches.subscribe(onNext: { [weak self] (_) in
            self?.loadingSubject.accept(true)
        }).disposed(by: disposeBag)
    }
}
