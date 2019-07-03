//
//  DataBaseManager.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/1/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import SQLiteManager
class DatabaseManager {

    static let shared = DatabaseManager()
    private init() {
        createDB()
    }
    var db: OpaquePointer?
    var database: SQLite!

    private func createDB() {
            database = try? SQLitePool.manager().initialize(database: "football leagues", withExtension: "sqlite3", createIfNotExist: true)
    }
   private func createLeaguesTable() {
        database.query("CREATE TABLE IF NOT EXISTS Leagues (id INTEGER PRIMARY KEY , title TEXT, leagueIcon Data , title1 TEXT , titke1Icon Data , title2 TEXT , titke2Icon Data)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    private func createTeamsTable() {
        database.query("CREATE TABLE IF NOT EXISTS Teams (id INTEGER PRIMARY KEY , teamID INTEGER, title TEXT, teamIcon Data)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    func insertNewLeagues(leagues: [Competition]) {
        createLeaguesTable()
       
        for league in leagues {
            _ = try! database.bindQuery("INSERT INTO 'Leagues' (id, title, leagueIcon, title1, titke1Icon, title2, titke2Icon) VALUES (?,?,?,?,?,?)",
                                            bindValues: [sqlNumber(league.id ?? 0),
                                                         sqlStr(league.name ?? "test"),
                                                         sqlData(league.imageData ?? Data()),
                                                         sqlStr(league.name ?? "test"),
                                                         sqlData(league.imageData ?? Data()),
                                                         sqlStr(league.name ?? "test"),
                                                         sqlData(league.imageData ?? Data())])
        }
    }
    func insertNewTeams(teams: [Team],with id : Int) {
        createTeamsTable()
        for team in teams {
            _ = try! database.bindQuery("INSERT INTO 'Teams' (id, teamID, title, teamIcon) VALUES (?,?,?)",
                                        bindValues: [sqlNumber(id),
                                                     sqlNumber(team.id ?? 0),
                                                     sqlStr(team.name ?? "test"),
                                                     sqlData(team.imageData ?? Data()),
                                                    ])
        }
    }
    func deleteLeaguesLocalData() {
        _ = try? database.query("DELETE FROM 'Leagues'")
    }
    func deleteTeamsData(id:String) {
        _ = try? database.query("DELETE FROM 'Teams' WHERE id = \(id) ")
    }

    func getLocalLeagues(completion: @escaping([Competition])->Void) {
        createDB()
        var leagues: [Competition] = []
        let q1 = "SELECT * FROM Leagues"
        database.query([q1], successClosure: { (batchResult) in

            print("Time taken to proces", batchResult.timeTaken)
            for result in batchResult.results {
                for r in result.results ?? [] {
                    let league = Competition(id: r["id"]! as? Int, area: nil, name: r["title"]! as? String, code: nil, emblemURL: nil, plan: nil, currentSeason: nil, numberOfAvailableSeasons: 2, imageData: r["leagueIcon"] as? Data)
                    leagues.append(league)
                }
            }
            completion(leagues)
        }, errorClosure: { (e) in
            print(e)
        })
    }
    
    func getLocalTeams(with id: Int, completion: @escaping([Team])->Void) {
        createDB()
        var teams: [Team] = []
        let q1 = "SELECT * FROM Teams"
        database.query([q1], successClosure: { (batchResult) in
            
            print("Time taken to proces", batchResult.timeTaken)
            for result in batchResult.results {
                for r in result.results ?? [] {
                    let team = Team(id: r["teamID"] as? Int, area: nil, name: r["title"] as? String, shortName: nil, tla: nil, crestURL: nil, address: nil, phone: nil, website: nil, email: nil, founded: nil, clubColors: nil, venue: nil, imageData: r["teamIcon"] as? Data)
                    teams.append(team)
                }
            }
            completion(teams)
        }, errorClosure: { (e) in
            print(e)
        })
    }
}
