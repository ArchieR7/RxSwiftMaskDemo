//
//  MaskPointTableViewModel.swift
//  RxSwiftDemo
//
//  Created by Archie on 2020/5/5.
//  Copyright © 2020 Archie. All rights reserved.
//

import RxCocoa
import RxSwift

final class MaskPointTableViewModel {
    fileprivate let present: BehaviorSubject<[MaskCellModel]> = BehaviorSubject(value: [])
    let disposeBag: DisposeBag = DisposeBag()
    
    func getMaskPoints() {
        MaskAPI.GetPoints().request().asObservable()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { $0.features.cellModels() }
            .bind(to: present)
            .disposed(by: disposeBag)
    }
}

extension MaskPointTableViewModel: ReactiveCompatible {}
extension Reactive where Base: MaskPointTableViewModel {
    var cellModels: ControlEvent<[MaskCellModel]> {
        ControlEvent(events: base.present)
    }
}
extension Collection where Element == MaskPoint {
    func cellModels() -> [MaskCellModel] {
        var dictionary: [String: Int] = [:]
        for point in self {
            if let value: Int = dictionary[point.properties.county] {
                dictionary[point.properties.county] = value + point.properties.maskAdult
            } else {
                dictionary[point.properties.county] = point.properties.maskAdult
            }
        }
        return dictionary.map {
            MaskCellModel(name: $0.key, count: $0.value.description)
        }
    }
}
