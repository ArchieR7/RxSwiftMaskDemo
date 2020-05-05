//
//  DatabaseManager.swift
//  RxSwiftDemo
//
//  Created by Archie on 2020/5/5.
//  Copyright © 2020 Archie. All rights reserved.
//

import CouchbaseLiteSwift

final class DatabaseManager {
    static let shared: DatabaseManager = DatabaseManager()
    private let database: Database
    
    private init() {
        do {
            database = try Database(name: "db")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
