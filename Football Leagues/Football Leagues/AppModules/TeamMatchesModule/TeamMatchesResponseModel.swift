//
//  TeamMatchesResponseModel.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/2/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
class TeamMatchesResponseModel: Codable {
    let count: Int
    let filters: Filters?
    let matches: [Match]?
    
    init(count: Int, filters: Filters?, matches: [Match]?) {
        self.count = count
        self.filters = filters
        self.matches = matches
    }
}

// MARK: - Match
class Match: Codable {
    let id: Int?
    let competition: Competition?
    let season: Season?
    let utcDate: Date?
    let status: String?
    let minute: JSONNull?
    let attendance: Int?
    let matchday: Int?
    let stage, group: String?
    let lastUpdated: Date?
    let referees: [Coach]?
    let homeTeam, awayTeam: Team?
    let score: Score?
    let goals: [Goal]?
    let bookings: [Booking]?
    let substitutions: [Substitution]?
    
    init(id: Int?, competition: Competition?, season: Season?, utcDate: Date?, status: String?, minute: JSONNull?, attendance: Int?, matchday: Int?, stage: String?, group: String?, lastUpdated: Date?, referees: [Coach]?, homeTeam: Team?, awayTeam: Team?, score: Score?, goals: [Goal]?, bookings: [Booking]?, substitutions: [Substitution]?) {
        self.id = id
        self.competition = competition
        self.season = season
        self.utcDate = utcDate
        self.status = status
        self.minute = minute
        self.attendance = attendance
        self.matchday = matchday
        self.stage = stage
        self.group = group
        self.lastUpdated = lastUpdated
        self.referees = referees
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.score = score
        self.goals = goals
        self.bookings = bookings
        self.substitutions = substitutions
    }
}
// MARK: - Booking
class Booking: Codable {
    let minute: Int?
    let team, player: Competition?
    let card: Card?
    
    init(minute: Int?, team: Competition?, player: Competition?, card: Card?) {
        self.minute = minute
        self.team = team
        self.player = player
        self.card = card
    }
}
// MARK: - Captain
class Captain: Codable {
    let id: Int?
    let name: String?
    let position: Position?
    let shirtNumber: Int?
    
    init(id: Int?, name: String?, position: Position?, shirtNumber: Int?) {
        self.id = id
        self.name = name
        self.position = position
        self.shirtNumber = shirtNumber
    }
}

enum Position: String, Codable {
    case attacker = "Attacker"
    case defender = "Defender"
    case goalkeeper = "Goalkeeper"
    case midfielder = "Midfielder"
}

// MARK: - Coach
class Coach: Codable {
    let id: Int?
    let name, countryOfBirth, nationality: String?
    
    init(id: Int?, name: String?, countryOfBirth: String?, nationality: String?) {
        self.id = id
        self.name = name
        self.countryOfBirth = countryOfBirth
        self.nationality = nationality
    }
}
enum Card: String, Codable {
    case yellowCard = "YELLOW_CARD"
    case yellowRedCard = "YELLOW_RED_CARD"
}
// MARK: - Goal
class Goal: Codable {
    let minute: Int?
    let scorer: Competition?
    let assist: [Competition]?
    
    init(minute: Int?, scorer: Competition?, assist: [Competition]?) {
        self.minute = minute
        self.scorer = scorer
        self.assist = assist
    }
}

// MARK: - Score
class Score: Codable {
    let winner: String?
    let duration: String?
    let halfTime, fullTime, extraTime, penalties: ExtraTime?
    
    init(winner: String?, duration: String?, halfTime: ExtraTime?, fullTime: ExtraTime?, extraTime: ExtraTime?, penalties: ExtraTime?) {
        self.winner = winner
        self.duration = duration
        self.halfTime = halfTime
        self.fullTime = fullTime
        self.extraTime = extraTime
        self.penalties = penalties
    }
}

// MARK: - ExtraTime
class ExtraTime: Codable {
    let homeTeam, awayTeam: Int?
    
    init(homeTeam: Int?, awayTeam: Int?) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}
// MARK: - Substitution
class Substitution: Codable {
    let minute: Int?
    let team, playerOut, playerIn: Competition?
    
    init(minute: Int?, team: Competition?, playerOut: Competition?, playerIn: Competition?) {
        self.minute = minute
        self.team = team
        self.playerOut = playerOut
        self.playerIn = playerIn
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
