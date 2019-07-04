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

    var database: SQLite!
    static let shared = DatabaseManager()
    private init() {
        createDB()
    }
    private func createDB() {
        database = try? SQLitePool.manager().initialize(database: "football leagues", withExtension: "sqlite3", createIfNotExist: true)
    }
    func saveLeaguesData(leagues: [Competition]){
        LeaguesSQLManager.shared.deleteLeaguesLocalData()
        LeaguesSQLManager.shared.insertNewLeagues(leagues: leagues)
    }
    func getLeaguesData(completion: @escaping([Competition]) -> Void) {
         LeaguesSQLManager.shared.getLocalLeagues(completion: completion)
    }
    func saveTeamsData(team: TeamsResponseModel, leagueid: Int ){
        TeamsSQLManager.shared.deleteTeamsData(leagueId: leagueid)
        TeamsSQLManager.shared.insertNewTeams(team: team, with: leagueid)
    }
    func getTeamsData(leagueid: Int, completion: @escaping(TeamsResponseModel) -> Void) {
        TeamsSQLManager.shared.getLocalTeams(leagueid: leagueid, completion: completion)
    }
}
