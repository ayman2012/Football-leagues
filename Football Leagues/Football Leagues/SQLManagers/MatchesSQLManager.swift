//
//  MatchesSQLManager.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/4/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation

import Foundation
import SQLiteManager

class MatchesSQLManager {
    
    static let shared = MatchesSQLManager()
    private init() {
        createDB()
    }
    var db: OpaquePointer?
    var database: SQLite!
    private func createDB() {
        database = try? SQLitePool.manager().initialize(database: "football leagues", withExtension: "sqlite3", createIfNotExist: true)
        createMatchesTable()
    }
    
    private func createMatchesTable() {
        database.query("CREATE TABLE IF NOT EXISTS Matches (id INTEGER , matchID INTEGER, homeTeamURl TEXT, awayTeamURL TEXT, homeTeamScore INTEGER, awayTeamScore INTEGER, status TEXT , date Date)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    func insertNewMatches(teamMatches: TeamMatchesResponseModel, with teamId: Int) {
        for match in teamMatches.matches ?? [] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: match.utcDate ?? Date())
            _ = try! database.bindQuery("INSERT INTO 'Matches' (id, matchID, homeTeamURl, awayTeamURL ,homeTeamScore, awayTeamScore,status, date  ) VALUES (?,?,?,?)",
                                        bindValues: [sqlNumber(teamId),
                                                     sqlNumber(match.id ?? 0),
                                                     sqlStr(match.homeTeam?.crestURL ?? ""),
                                                     sqlStr(match.awayTeam?.crestURL ?? ""),
                                                     sqlNumber(match.score?.fullTime?.homeTeam ?? 0),
                                                     sqlNumber(match.score?.fullTime?.awayTeam ?? 0),
                                                     sqlStr(match.status ?? ""),
                                                     sqlStr(dateString)])
        }
    }
    
    func deleteMatchesData(leagueId: Int) {
        if database != nil {
            _ = try? database.query("DELETE FROM 'Matches' WHERE id = \(leagueId) ")
        }
    }
    func getLocalMatches(leagueId id: Int, completion: @escaping([Match]) -> Void) {
        if database != nil {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "YYYY-MM-DDTHH:MM:SSZ"
            
            var matches: [Match] = []
            let q1 = "SELECT * FROM Matches WHERE id = \(id)"
            database.query([q1], successClosure: { (batchResult) in
                
                print("Time taken to proces", batchResult.timeTaken)
                for result in batchResult.results {
                    for r in result.results ?? [] {
                        let hometeam = Team.init(id: nil, area: nil, name: nil, shortName: nil, tla: nil, crestURL: r["homeTeamURl"] as? String, address: nil, phone: nil, website: nil, email: nil, founded: nil, clubColors: nil, venue: nil)
                        
                         let awayteam = Team.init(id: nil, area: nil, name: nil, shortName: nil, tla: nil, crestURL: r["awayTeamURL"] as? String, address: nil, phone: nil , website: nil, email: nil, founded: nil, clubColors: nil, venue: nil)
                        let fullTime = ExtraTime.init(homeTeam: r["homeTeamScore"] as? Int , awayTeam: r["awayTeamScore"] as? Int )
                        
                        let score = Score.init(winner: nil, duration: nil, halfTime: nil, fullTime: fullTime, extraTime: nil, penalties: nil)
                        
                        let match = Match.init(id: r["matchID"] as? Int,
                                               competition: nil, season: nil,
                                               utcDate: dateFormatterPrint.date(from: r["date"] as? String ?? ""),
                                               status: r["status"] as? String,
                                               minute: nil, attendance: nil,
                                               matchday: nil, stage: nil,
                                               group: nil, lastUpdated: nil,
                                               referees: nil, homeTeam: hometeam ,
                                               awayTeam: awayteam, score: score,
                                               goals: nil, bookings: nil,
                                               substitutions: nil)
                        matches.append(match)
                    }
                }
            }, errorClosure: { (e) in
                print(e)
            })
        }
    }
}
