//
//  MaskPointTests.swift
//  RxSwiftDemoTests
//
//  Created by Archie on 2020/5/5.
//  Copyright © 2020 Archie. All rights reserved.
//

import RxSwift
import XCTest
@testable import RxSwiftDemo

class MaskPointTests: XCTestCase {
    private let point: MaskPoint = {
        let properties: MaskPoint.Property = MaskPoint.Property(id: UUID().uuidString,
                                                                county: "宜蘭縣",
                                                                updated: "2020/5/5",
                                                                maskAdult: 108)
        return MaskPoint(properties: properties)
    }()
    private lazy var cellModel: [MaskCellModel] = [point].cellModels()
    private lazy var tableViewModel: MaskPointTableViewModel = MaskPointTableViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    func testCellModel() {
        XCTAssertEqual(cellModel.first?.count, "108")
    }
    
    func testTableViewModel() {
        let exp: XCTestExpectation = expectation(description: "Test table view models api.")
        tableViewModel.rx.cellModels.skip(1).subscribe(onNext: { cellModels in
            XCTAssertFalse(cellModels.isEmpty)
            exp.fulfill()
        }, onError: { error in
            print(error)
            fatalError(error.localizedDescription)
        }).disposed(by: disposeBag)
        tableViewModel.getMaskPoints()
        wait(for: [exp], timeout: 3)
    }
}
