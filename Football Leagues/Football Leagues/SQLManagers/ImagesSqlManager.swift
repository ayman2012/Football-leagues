//
//  ImagesSqlManager.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/4/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import SQLiteManager

class ImagesSqlManager {
    static let shared = ImagesSqlManager()
    private init() {
        createDB()
    }
    var db: OpaquePointer?
    var database: SQLite!
    
    private func createDB() {
        database = try? SQLitePool.manager().initialize(database: "football leagues", withExtension: "sqlite3", createIfNotExist: true)
       createImageTable()
    }
    
    private func createImageTable() {
        database.query("CREATE TABLE IF NOT EXISTS Images (imageURL TEXT PRIMARY KEY, ImageData Data)", successClosure: { _ in
            print("Done")
        }) { err in
            print(err)
        }
    }
    
    func insertNewImage(imageURL:String, imagedata:Data) {
         if  database != nil {
            _ = try! database.bindQuery("INSERT INTO 'Images' (imageURL, ImageData) VALUES (?,?)",
                                        bindValues: [sqlStr(imageURL),
                                                     sqlData(imagedata)])
        }
    }
    
    func getImageData(imageURL:String,completion: @escaping(Data?) -> Void) {
        if  database != nil {
        let q1 = "SELECT * FROM CompetionTeams WHERE imageURL = \(imageURL)"
        database.query([q1], successClosure: { (batchResult) in
            print("Time taken to proces", batchResult.timeTaken)
            for result in batchResult.results {
                for r in result.results ?? [] {
                    let imageData = r["ImageData"] as? Data
                    completion(imageData)
                }
            }
        }, errorClosure: { (e) in
            print(e)
        })
    }
    }
}

