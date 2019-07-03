//
//  TeamMatchesAssembler.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class TeamMatchesAssembler: Assembly {
    func assemble(container: Container) {
        assembleTeamMatchesModule(container: container)
        container.storyboardInitCompleted(TeamMatchesViewController.self) { (r, c) in
            c.initialize(teamsMatchesViewModel: r.resolve(TeamMatchesViewModel.self)!)
        }
    }
    
    private func assembleTeamMatchesModule(container: Container) {
        container.register(TeamMatchesRepository.self) { (_) in
            TeamMatchesRepository()
        }
        container.register(TeamMatchesViewModel.self) { (resolver) in
            TeamMatchesViewModel(repository: resolver.resolve(TeamMatchesRepository.self)!)
        }
    }
}
