//
//  LeaguesResponseModel.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
class LeaguesResponseModel: Codable {
    let count: Int
    let filters: Filters?
    let competitions: [Competition]?

    init(count: Int, filters: Filters?, competitions: [Competition]?) {
        self.count = count
        self.filters = filters
        self.competitions = competitions
    }
}

// MARK: - Competition
class Competition: Codable {
    let id: Int?
    let area: Area?
    let name: String?
    let code: String?
    let emblemURL: String?
    let plan: Plan?
    let currentSeason: CurrentSeason?
    let numberOfAvailableSeasons: Int?
    let imageData: Data?
    enum CodingKeys: String, CodingKey {
        case id, area, name, code, imageData
        case emblemURL = "emblemUrl"
        case plan, currentSeason, numberOfAvailableSeasons
    }

    init(id: Int?, area: Area?, name: String?, code: String?, emblemURL: String?, plan: Plan?, currentSeason: CurrentSeason?, numberOfAvailableSeasons: Int?, imageData: Data?) {
        self.id = id
        self.area = area
        self.name = name
        self.code = code
        self.emblemURL = emblemURL
        self.plan = plan
        self.currentSeason = currentSeason
        self.numberOfAvailableSeasons = numberOfAvailableSeasons
        self.imageData = imageData
    }
}

// MARK: - Area
class Area: Codable {
    let id: Int?
    let name: String?

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: - CurrentSeason
class CurrentSeason: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
    let winner: Winner?

    init(id: Int?, startDate: String?, endDate: String?, currentMatchday: Int?, winner: Winner?) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.currentMatchday = currentMatchday
        self.winner = winner
    }
}

// MARK: - Winner
class Winner: Codable {
    let id: Int?
    let name: String?
    let shortName, tla: String?
    let crestURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, shortName, tla
        case crestURL = "crestUrl"
    }

    init(id: Int?, name: String?, shortName: String?, tla: String?, crestURL: String?) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.crestURL = crestURL
    }
}

enum Plan: String, Codable {
    case tierFour = "TIER_FOUR"
    case tierOne = "TIER_ONE"
    case tierThree = "TIER_THREE"
    case tierTwo = "TIER_TWO"
}

// MARK: - Filters
class Filters: Codable {

    init() {
    }
}

//===================================================
//// MARK: - Competition
//struct Competition: Codable {
//    let id: Int?
//    let name: String?
//    let code: String?
//    let emblemURL: String?
//    let plan: Plan?
//    let currentSeason: CurrentSeason?
//    let numberOfAvailableSeasons: Int?
//    enum CodingKeys: String, CodingKey {
//        case id, area, name, code
//        case emblemURL = "emblemUrl"
//        case plan, currentSeason, numberOfAvailableSeasons//, lastUpdated
//    }
////    init(name:String,imageData: Data) {
////        id = 2
////        self.name = name
////        code = ""
////        emblemURL = ""
////        plan = .tierTwo
////        currentSeason = CurrentSeason()
////        numberOfAvailableSeasons = 2
////        self.imageData = imageData
////    }
//}
//
//// MARK: - Area
//struct Area: Codable {
//    let id: Int?
//    let name: String?
////    init(id:Int, name,) {
////        <#statements#>
////    }
//}
//
//// MARK: - CurrentSeason
//struct CurrentSeason: Codable {
//    let id: Int?
//    let startDate, endDate: String?
//    let currentMatchday: Int?
//    let winner: Winner?
////    init(is:Int,startDate:String,endDate:String,currentMatchday:Int) {
////
////    }
////    init() {
////        id = 1
////        startDate = ""
////        endDate = ""
////        currentMatchday = 8
////        winner = Winner()
////    }
//}
//
//// MARK: - Winner
//struct Winner: Codable {
//    let id: Int?
//    let name: String?
//    let shortName, tla: String?
//    let crestURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, shortName, tla
//        case crestURL = "crestUrl"
//    }
////    init() {
////        id = 2
////        name = ""
////        shortName = ""
////        tla = ""
////        crestURL = ""
////    }
//
////    init(id:Int,name:String,shortName:String,tla:String,crestUrl:String) {
////        self.id = id
////        self.name = name
////        self.shortName = shortName
////        self.tla = tla
////        self.crestURL = crestUrl
////    }
//}
//
//enum Plan: String, Codable {
//    case tierFour = "TIER_FOUR"
//    case tierOne = "TIER_ONE"
//    case tierThree = "TIER_THREE"
//    case tierTwo = "TIER_TWO"
//}
//
