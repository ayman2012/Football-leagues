//
//  DataBaseManager.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/1/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import SQLite
class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    var database: Connection!
    func createDB() {
        do {   let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = directory.appendingPathComponent("football leagues").appendingPathExtension("sqlite3")
             self.database = try Connection(fileUrl.path)
        } catch {
            print(error)
        }
    }

}
