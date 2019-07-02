//
//  TeamsViewModel.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/2/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class TeamsViewModel {
    
    let loadingSubject = PublishRelay<Bool>()
    let title: String = "Football Leagues"
    var teamsItems = BehaviorRelay<TeamsResponseModel?>(value:nil)
    var disposeBag = DisposeBag()
    private let teamsRepository: TeamsRepository!
    
    init(repository: TeamsRepository) {
        self.teamsRepository = repository
    }
    func configerBinding(Id:String) {
        teamsRepository.getLeaguesObserable(competitionId:Id).bind(to: teamsItems)
        teamsItems.subscribe(onNext: { [weak self] (_) in
            self?.loadingSubject.accept(true)
        }).disposed(by: disposeBag)
    }

}
