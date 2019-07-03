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
    var id: String?
    var navigation: UINavigationController?
    init(navigation: UINavigationController ,id: String) {
        self.id = id
        self.navigation = navigation
    }
    func start() {
        if let teamsVC = SwinjectStoryboard.create(name: "Teams", bundle: nil).instantiateViewController(withIdentifier: "TeamsViewController") as? TeamsViewController {
            teamsVC.teamsViewModel.configerBinding(Id: "\(id)")
            navigation?.pushViewController(teamsVC, animated: true)
        }
    }
}
