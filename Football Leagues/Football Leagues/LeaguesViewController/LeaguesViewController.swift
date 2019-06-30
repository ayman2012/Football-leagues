//
//  LeaguesViewController.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit
class LeaguesViewController : UIViewController {
    
    private var leaguesViewModel: LeaguesViewModel!
    
    func initialize(leaguesViewModel:LeaguesViewModel) {
        self.leaguesViewModel = leaguesViewModel
    }
}
