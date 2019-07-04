//
//  TeamsCoordinator.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard

class TeamsCoordinator: Coordinator {
    var leagueId: Int?
    var navigation: UINavigationController?
    init(navigation: UINavigationController, leagueId: Int) {
        self.leagueId = leagueId
        self.navigation = navigation
    }
    func start() {
        if let teamsVC = SwinjectStoryboard.create(name: "Teams", bundle: nil).instantiateViewController(withIdentifier: "TeamsViewController") as? TeamsViewController {
            teamsVC.teamsViewModel.configerBinding(Id: leagueId ?? 0)
            navigation?.pushViewController(teamsVC, animated: true)
        }
    }
}
