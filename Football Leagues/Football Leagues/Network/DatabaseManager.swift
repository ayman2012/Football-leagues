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
        database.query("CREATE TABLE IF NOT EXISTS Leagues (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, leagueIcon T , title1 TEXT , titke1Icon Data , title2 TEXT , titke2Icon Data)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    func insertNewLeagues(leagues: [Competition]) {
        createLeaguesTable()
        let image: UIImage = UIImage(named: "logo")!
        let imageData: Data = image.pngData()!

        for league in leagues {
            _ = try! database.bindQuery("INSERT INTO 'Leagues' (title, leagueIcon, title1, titke1Icon, title2, titke2Icon) VALUES (?,?,?,?,?,?)",
                                            bindValues: [sqlStr(league.name ?? "test"),
                                                         sqlData(imageData),
                                                         sqlStr(league.name ?? "test"),
                                                         sqlData(imageData),
                                                         sqlStr(league.name ?? "test"),
                                                         sqlData(imageData)])
        }
    }
    func deleteLeaguesLocalData() {
        _ = try? database.query("DELETE FROM 'Leagues'")
    }

    func getLocalLeagues(completion: @escaping([Competition])->Void) {
        createDB()
        var leagues: [Competition] = [Competition(id: nil, area: nil, name: "test", code: nil, emblemURL: nil, plan: nil, currentSeason: nil, numberOfAvailableSeasons: 2, imageData: nil)]
        let q1 = "SELECT * FROM Leagues"
        database.query([q1], successClosure: { (batchResult) in

            print("Time taken to proces", batchResult.timeTaken)
            for result in batchResult.results {
                for r in result.results ?? [] {
                    print(r["title"]!)
                    let temp = Competition(id: nil, area: nil, name: r["title"]! as? String, code: nil, emblemURL: nil, plan: nil, currentSeason: nil, numberOfAvailableSeasons: 2, imageData: r["leagueIcon"] as? Data)
                    leagues.append(temp)
                }
            }
            completion(leagues)
        }, errorClosure: { (e) in
            print(e)
        })
    }
}
