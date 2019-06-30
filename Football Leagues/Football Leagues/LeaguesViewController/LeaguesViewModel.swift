//
//  LeaguesViewModel.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation

class LeaguesViewModel {
    
    private let leaguesRepository: LeaguesRepository!
    init(repository: LeaguesRepository) {
        self.leaguesRepository = repository
    }
    
}
