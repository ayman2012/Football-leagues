//
//  TeamsResponseModel.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/2/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
class TeamsResponseModel: Codable {
    let count: Int
    let filters: Filters?
    let competition: Competition?
    let season: Season?
    let teams: [Team]?
    
    init(count: Int, filters: Filters?, competition: Competition?, season: Season?, teams: [Team]?) {
        self.count = count
        self.filters = filters
        self.competition = competition
        self.season = season
        self.teams = teams
    }
}
// MARK: - Season
class Season: Codable {
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
// MARK: - Team
class Team: Codable {
    let id: Int?
    let area: Area?
    let name, shortName, tla: String?
    let crestURL: String?
    let address, phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors, venue: String?
    
    enum CodingKeys: String, CodingKey {
        case id, area, name, shortName, tla
        case crestURL = "crestUrl"
        case address, phone, website, email, founded, clubColors, venue
    }
    
    init(id: Int?, area: Area?, name: String?, shortName: String?, tla: String?, crestURL: String?, address: String?, phone: String?, website: String?, email: String?, founded: Int?, clubColors: String?, venue: String?) {
        self.id = id
        self.area = area
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.crestURL = crestURL
        self.address = address
        self.phone = phone
        self.website = website
        self.email = email
        self.founded = founded
        self.clubColors = clubColors
        self.venue = venue
    }
}
