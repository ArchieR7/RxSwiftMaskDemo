//
//  MaskAPITests.swift
//  RxSwiftDemoTests
//
//  Created by Archie on 2020/5/4.
//  Copyright © 2020 Archie. All rights reserved.
//

import RxSwift
import XCTest
@testable import RxSwiftDemo

class MaskAPITests: XCTestCase {
    private let disposeBag: DisposeBag = DisposeBag()
    
    func testGetPointsAPI() {
        let exp: XCTestExpectation = expectation(description: "Test get points api.")
        MaskAPI.GetPoints().request().subscribe(onSuccess: { (response) in
            XCTAssertFalse(response.features.isEmpty)
            exp.fulfill()
        }) { error in
            print(error)
            fatalError(error.localizedDescription)
        }
        .disposed(by: disposeBag)
        wait(for: [exp], timeout: 3)
    }
}

