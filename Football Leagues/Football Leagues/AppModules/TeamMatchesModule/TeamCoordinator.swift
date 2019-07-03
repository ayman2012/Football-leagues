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
    var id: String?
    var navigation: UINavigationController?
    init(navigation: UINavigationController ,id: String) {
        self.id = id
        self.navigation = navigation
    }
    func start() {
        if let teamsVC = SwinjectStoryboard.create(name: "TeamMatches", bundle: nil).instantiateViewController(withIdentifier: "TeamMatchesViewController") as? TeamMatchesViewController {
            teamsVC.teamsMatchesViewModel.configerBinding(Id: "\(id)")
            navigation?.pushViewController(teamsVC, animated: true)
        }
    }
}
