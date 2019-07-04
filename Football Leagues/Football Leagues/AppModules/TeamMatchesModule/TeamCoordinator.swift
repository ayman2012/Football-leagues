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
    var teamsId: Int?
    var teamName: String?
    var teamImageUrl: String?
    var navigation: UINavigationController?
    init(navigation: UINavigationController, teamsId: Int, teamName:String, teamImageURL:String) {
        self.teamsId = teamsId
        self.teamName = teamName
        self.teamImageUrl = teamImageURL
        self.navigation = navigation
    }
    func start() {
        if let teamsVC = SwinjectStoryboard.create(name: "TeamMatches", bundle: nil).instantiateViewController(withIdentifier: "TeamMatchesViewController") as? TeamMatchesViewController {
            teamsVC.teamsMatchesViewModel.configerBinding(Id: teamsId ?? 0, teamName: teamName ?? "",teamImageURL: teamImageUrl ?? "")
            navigation?.pushViewController(teamsVC, animated: true)
        }
    }
}
