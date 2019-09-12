//
//  LeaguesCoordinator.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard
protocol Coordinator: class {
    func start()
}
class LeaguesCoordinator: Coordinator {
    var window: UIWindow
//    var coordinators = [String: Coordinator]()
    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }

    func start() {
        if let LeaguesVC = SwinjectStoryboard.create(name: "Leagues", bundle: nil).instantiateViewController(withIdentifier: "LeaguesViewController") as? LeaguesViewController {
            window.rootViewController = UINavigationController.init(rootViewController: LeaguesVC)
        }
    }
}
