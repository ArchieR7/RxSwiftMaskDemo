//
//  CouchbaseTests.swift
//  RxSwiftDemoTests
//
//  Created by Archie on 2020/5/7.
//  Copyright © 2020 Archie. All rights reserved.
//

import XCTest
@testable import RxSwiftDemo

class CouchbaseTests: XCTestCase {
    private let point: MaskPoint = MaskPoint(properties: MaskPoint.Property(id: "1", county: "宜蘭縣", updated: "2020/5/7", maskAdult: 10))
    private let point2: MaskPoint = MaskPoint(properties: MaskPoint.Property(id: "2", county: "花蓮縣", updated: "2020/5/7", maskAdult: 12))
    private let point3: MaskPoint = MaskPoint(properties: MaskPoint.Property(id: "3", county: "屏東縣", updated: "2020/5/7", maskAdult: 12))
    private let note: String = "Test"
    private let note2: String = "test"
    private let note3: String = "test"
    
    func testCreateDatabase() {
        DatabaseManager.shared.create(point: point, note: note)
        DatabaseManager.shared.create(point: point2, note: note2)
        DatabaseManager.shared.create(point: point3, note: note3)
    }
    
    func testReadDatabase() {
        XCTAssertEqual(note, DatabaseManager.shared.getNote(point: point))
        XCTAssertEqual(note2, DatabaseManager.shared.getNote(point: point2))
        XCTAssertEqual(note3, DatabaseManager.shared.getNote(point: point3))
    }
    
    func testUpdateDatabase() {
        DatabaseManager.shared.update(point: point, note: note2)
        XCTAssertEqual(note2, DatabaseManager.shared.getNote(point: point))
    }
    
    func testDatabaseManager() {
        DatabaseManager.shared.delete(point: point)
        DatabaseManager.shared.delete(point: point2)
        DatabaseManager.shared.delete(point: point3)
        XCTAssertEqual(nil, DatabaseManager.shared.getNote(point: point))
        XCTAssertEqual(nil, DatabaseManager.shared.getNote(point: point2))
        XCTAssertEqual(nil, DatabaseManager.shared.getNote(point: point3))
    }
}
