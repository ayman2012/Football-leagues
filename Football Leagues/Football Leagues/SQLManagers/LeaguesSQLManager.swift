//
//  LeaguesSQLManager.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/4/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import SQLiteManager
class LeaguesSQLManager {
    static let shared = LeaguesSQLManager()
    private init() {
        createDB()
    }
    var db: OpaquePointer?
    var database: SQLite!
    
    private func createDB() {
        database = try? SQLitePool.manager().initialize(database: "football leagues", withExtension: "sqlite3", createIfNotExist: true)
        createLeaguesTable()
    }
    
    private func createLeaguesTable() {
        database.query("CREATE TABLE IF NOT EXISTS Leagues (id INTEGER PRIMARY KEY , title TEXT, leagueIconURL TEXT , numberOfAvailableSeasons INTEGER , winerIconURL TEXT , winerName TEXT )", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    
    func insertNewLeagues(leagues: [Competition]) {
        if database != nil {
            for league in leagues {
                _ = try! database.bindQuery("INSERT INTO 'Leagues' (id, title, leagueIconURL, numberOfAvailableSeasons, winerIconURL, winerName) VALUES (?,?,?,?,?,?)",
                                            bindValues: [sqlNumber(league.id ?? 0),
                                                         sqlStr(league.name ?? ""),
                                                         sqlStr(league.emblemURL ?? ""),
                                                         sqlNumber(league.numberOfAvailableSeasons ?? 0),
                                                         sqlStr(league.currentSeason?.winner?.crestURL ?? ""),
                                                         sqlStr(league.currentSeason?.winner?.name ?? "")])
            }
        }
    }
    
    func getLocalLeagues(completion: @escaping([Competition]) -> Void) {
        if database != nil {
            var leagues: [Competition] = []
            let q1 = "SELECT * FROM Leagues"
            database.query([q1], successClosure: { (batchResult) in
                print("Time taken to proces", batchResult.timeTaken)
                for result in batchResult.results {
                    for r in result.results ?? [] {
                        let winner = Winner.init(id: 0, name:  r["winerName"] as? String, shortName: nil, tla: nil, crestURL:  r["winerIconURL"] as? String)
                        let league = Competition(id: r["id"]! as? Int, area: nil,
                                                 name: r["title"]! as? String,
                                                 code: nil, emblemURL: r["leagueIconURL"] as? String,
                                                 plan: nil, currentSeason: CurrentSeason.init(id: 0, startDate: nil, endDate: nil, currentMatchday: nil, winner: winner ),
                                                 numberOfAvailableSeasons: r["numberOfAvailableSeasons"] as? Int)
                        leagues.append(league)
                    }
                }
                completion(leagues)
            }, errorClosure: { (e) in
                print(e)
            })
        }
    }
    
    func getLocalLeaguesWihId(leagueId:Int,completion: @escaping(Competition) -> Void) {
        if database != nil {
            let q1 = "SELECT * FROM Leagues WHERE id = \(leagueId)"
            database.query([q1], successClosure: { (batchResult) in
                print("Time taken to proces", batchResult.timeTaken)
                for result in batchResult.results {
                    for r in result.results ?? [] {
                        let winner = Winner.init(id: 0, name:  r["winerName"] as? String, shortName: nil, tla: nil, crestURL:  r["winerIconURL"] as? String)
                        let league = Competition(id: r["id"]! as? Int, area: nil,
                                                 name: r["title"]! as? String,
                                                 code: nil, emblemURL: r["leagueIconURL"] as? String,
                                                 plan: nil, currentSeason: CurrentSeason.init(id: 0, startDate: nil, endDate: nil, currentMatchday: nil, winner: winner ),
                                                 numberOfAvailableSeasons: r["numberOfAvailableSeasons"] as? Int)
                        completion(league)
                    }
                }
            }, errorClosure: { (e) in
                print(e)
            })
        }
    }
    
    func deleteLeaguesLocalData() {
        if database != nil {
            _ = try? database.query("DELETE FROM 'Leagues'")
        }
    }
}
