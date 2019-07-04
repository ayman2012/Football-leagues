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
    }
    
    private func createLeaguesTable() {
        database.query("CREATE TABLE IF NOT EXISTS Leagues (id INTEGER PRIMARY KEY , title TEXT, leagueIcon Data , title1 TEXT , title1Icon Data , title2 TEXT , title2Icon Data)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    
    func insertNewLeagues(leagues: [Competition]) {
        createLeaguesTable()
        for league in leagues {
            _ = try! database.bindQuery("INSERT INTO 'Leagues' (id, title, leagueIcon, title1, title1Icon, title2) VALUES (?,?,?,?,?,?)",
                                        bindValues: [sqlNumber(league.id ?? 0),
                                                     sqlStr(league.name ?? "test"),
                                                     sqlStr(league.emblemURL ?? ""),
                                                     sqlStr(league.name ?? "test"),
                                                     sqlStr(league.currentSeason?.winner?.crestURL ?? ""),
                                                     sqlStr(league.name ?? "test")])
        }
    }
    
    func getLocalLeagues(completion: @escaping([Competition]) -> Void) {
        createDB()
        var leagues: [Competition] = []
        let q1 = "SELECT * FROM Leagues"
        database.query([q1], successClosure: { (batchResult) in
            print("Time taken to proces", batchResult.timeTaken)
            for result in batchResult.results {
                for r in result.results ?? [] {
                    let league = Competition(id: r["id"]! as? Int, area: nil, name: r["title"]! as? String, code: nil, emblemURL: r["leagueIcon"] as? String, plan: nil, currentSeason: nil, numberOfAvailableSeasons: 2)
                    leagues.append(league)
                }
            }
            completion(leagues)
        }, errorClosure: { (e) in
            print(e)
        })
    }
    
    func deleteLeaguesLocalData() {
        _ = try? database.query("DELETE FROM 'Leagues'")
    }
}
