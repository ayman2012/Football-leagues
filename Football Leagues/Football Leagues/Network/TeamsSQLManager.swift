//
//  TeamsSQLManager.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/4/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import SQLiteManager

class TeamsSQLManager {
    
    static let shared = TeamsSQLManager()
    private init() {
        createDB()
    }
    var db: OpaquePointer?
    var database: SQLite!
    private func createDB() {
        database = try? SQLitePool.manager().initialize(database: "football leagues", withExtension: "sqlite3", createIfNotExist: true)
    }
    private func createTeamsTable() {
        database.query("CREATE TABLE IF NOT EXISTS Teams (id INTEGER , teamID INTEGER, title TEXT, teamIconURL TEXT)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
        database.query("CREATE TABLE IF NOT EXISTS CompetionTeams (id INTEGER , competionName TEXT, competionIconURL TEXT)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    func insertNewTeams(team: TeamsResponseModel, with leagueid: Int) {
        createTeamsTable()
        _ = try! database.bindQuery("INSERT INTO 'CompetionTeams' (id, competionName, competionIconURL) VALUES (?,?,?)",
                                    bindValues: [sqlNumber(leagueid),
                                                 sqlStr(team.competition?.name ?? "test Data"),
                                                 sqlStr(team.competition?.emblemURL ?? "")
            ])
        for team in team.teams ?? [] {
            _ = try! database.bindQuery("INSERT INTO 'Teams' (id, teamID, title, teamIconURL) VALUES (?,?,?,?)",
                                        bindValues: [sqlNumber(leagueid),
                                                     sqlNumber(team.id ?? 0),
                                                     sqlStr(team.name ?? "test"),
                                                     sqlStr(team.crestURL ?? "")
                ])
        }
    }
    
    func deleteTeamsData(leagueid: Int) {
        _ = try? database.query("DELETE FROM 'Teams' WHERE id = \(leagueid) ")
         _ = try? database.query("DELETE FROM 'CompetionTeams' WHERE id = \(leagueid) ")
    }
    func getLocalTeams(leagueid id: Int, completion: @escaping(TeamsResponseModel) -> Void) {
        createDB()
        var teams: [Team] = []
        let q1 = "SELECT * FROM Teams WHERE id = \(id)"
        database.query([q1], successClosure: { (batchResult) in
            
            print("Time taken to proces", batchResult.timeTaken)
            for result in batchResult.results {
                for r in result.results ?? [] {
                    let team = Team(id: r["teamID"] as? Int, area: nil, name: r["title"] as? String,
                                    shortName: nil, tla: nil, crestURL: r["teamIconURL"] as? String, address: nil, phone: nil,
                                    website: nil, email: nil, founded: nil, clubColors: nil, venue: nil)
                    teams.append(team)
                }
            }
           self.getCompetionTeamModel(leagueid: id) { competionTeam in
            let teamResponseModel = TeamsResponseModel.init(count: 0, filters: nil, competition: competionTeam, season: nil, teams: teams)
            completion(teamResponseModel)
            }
            
        }, errorClosure: { (e) in
            print(e)
        })
    }
    private func getCompetionTeamModel(leagueid id: Int, completion: @escaping(Competition?) -> Void) {
         createDB()
        var competionTeam: Competition?
        let q1 = "SELECT * FROM CompetionTeams WHERE id = \(id)"
        database.query([q1], successClosure: { (batchResult) in
            
            print("Time taken to proces", batchResult.timeTaken)
            for result in batchResult.results {
                for r in result.results ?? [] {
                   competionTeam = Competition.init(id: r["teamID"] as? Int, area: nil, name: r["competionName"] as? String, code: nil, emblemURL: r["competionIconURL"] as? String, plan: nil, currentSeason: nil, numberOfAvailableSeasons: nil)
                }
            }
            completion(competionTeam)
        }, errorClosure: { (e) in
            print(e)
        })
    }
}
