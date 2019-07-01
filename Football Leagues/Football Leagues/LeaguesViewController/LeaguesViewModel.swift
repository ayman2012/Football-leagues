//
//  LeaguesViewModel.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LeaguesViewModel {

    let loadingSubject = PublishRelay<Bool>()
    let title: String = ""
    var leaguesItems = BehaviorRelay<[Competition]>(value: [])
    var disposeBag = DisposeBag()
    private let leaguesRepository: LeaguesRepository!
    init(repository: LeaguesRepository) {
        self.leaguesRepository = repository
        configerBinding()
    }
    func configerBinding() {
        leaguesRepository.getLeaguesObserable().bind(to: leaguesItems)
        leaguesItems.subscribe(onNext: { [weak self] (_) in
            self?.loadingSubject.accept(true)
        }).disposed(by: disposeBag)
    }

}
