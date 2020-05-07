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
            database = try Database(name: "RxSwiftDemoDB")
            guard let path: String = database.path else { return }
            print("Couchbase path : \(path)")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func create(point: MaskPoint, note: String) {
        let document: MutableDocument = MutableDocument(id: point.properties.id)
        document.setValue(note, forKey: "note")
        document.setValue(point.properties.county, forKey: "county")
        do {
            try database.saveDocument(document)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(point: MaskPoint, note: String) {
        if let document: MutableDocument = database.document(withID: point.properties.id)?.toMutable() {
            document.setValue(note, forKey: "note")
            document.setValue(point.properties.county, forKey: "county")
            do {
                try database.saveDocument(document)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(point: MaskPoint) {
        if let document: MutableDocument = database.document(withID: point.properties.id)?.toMutable() {
            do {
                try database.deleteDocument(document)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("cannnot find the \(point.properties.id)")
        }
    }
    
    func getNote(point: MaskPoint) -> String? {
        let query = QueryBuilder.select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property("county").equalTo(Expression.string(point.properties.county)))
            .limit(Expression.int(1))
        do {
            let result: ResultSet = try query.execute()
            guard let point: Result = result.allResults().first else { return nil }
            guard let dictionary = point.dictionary(forKey: "RxSwiftDemoDB") else { return nil }
            return dictionary.string(forKey: "note")
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
