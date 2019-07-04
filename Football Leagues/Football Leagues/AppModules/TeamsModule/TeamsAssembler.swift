//
//  TeamsAssembler.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/2/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class TeamsAssembler: Assembly {

    func assemble(container: Container) {
        assembleTeamsModule(container: container)
        container.storyboardInitCompleted(TeamsViewController.self) { (r, c) in
            c.initialize(teamsViewModel: r.resolve(TeamsViewModel.self)!)
        }
    }

    private func assembleTeamsModule(container: Container) {
        container.register(TeamsRepository.self) { (_) in
            TeamsRepository()
        }

        container.register(TeamsViewModel.self) { (resolver) in
            TeamsViewModel(repository: resolver.resolve(TeamsRepository.self)!)
        }
    }
}
