//
//  LeaguesAssembler.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class LeaguesAssembler: Assembly {

    func assemble(container: Container) {
        assembleCurrentChargesModule(container: container)
        container.storyboardInitCompleted(LeaguesViewController.self) { (r, c) in
            c.initialize(leaguesViewModel: r.resolve(LeaguesViewModel.self)!)
        }
    }

    private func assembleCurrentChargesModule(container: Container) {
        container.register(LeaguesRepository.self) { (_) in
            LeaguesRepository()
        }

        container.register(LeaguesViewModel.self) { (resolver) in
            LeaguesViewModel(repository: resolver.resolve(LeaguesRepository.self)!)
        }
    }
}
