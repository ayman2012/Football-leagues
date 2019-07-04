//
//  TeamCoordinator.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard
class TeamCoordinator: Coordinator {
    var teamsId: String?
    var navigation: UINavigationController?
    init(navigation: UINavigationController, teamsId: String) {
        self.teamsId = teamsId
        self.navigation = navigation
    }
    func start() {
        if let teamsVC = SwinjectStoryboard.create(name: "TeamMatches", bundle: nil).instantiateViewController(withIdentifier: "TeamMatchesViewController") as? TeamMatchesViewController {
            teamsVC.teamsMatchesViewModel.configerBinding(Id: "\(teamsId)")
            navigation?.pushViewController(teamsVC, animated: true)
        }
    }
}
