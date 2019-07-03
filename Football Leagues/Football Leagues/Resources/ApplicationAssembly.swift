//
//  ApplicationAssembly.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class ApplicationAssembly {
    class var assembler: Assembler {
        return Assembler([LeaguesAssembler(),TeamsAssembler()])
    }
}

//Inject dependency in Main Storyboard
extension SwinjectStoryboard {

    @objc class func setup() {
        defaultContainer = (ApplicationAssembly.assembler.resolver as? Container)!
    }
}
