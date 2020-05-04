//
//  MaskAPI.swift
//  RxSwiftDemo
//
//  Created by Archie on 2020/5/4.
//  Copyright © 2020 Archie. All rights reserved.
//

import Moya

protocol MaskTargetType: APITargetType {}

extension MaskTargetType {
    var baseURL: URL {
        URL(string: "https://raw.githubusercontent.com/")!
    }
    var headers: [String : String]? { nil }
}

enum MaskAPI {
    struct GetPoints: MaskTargetType {
        struct ResponseType: Decodable {
            let features: [MaskPoint]
        }
        
        var path: String {
            "kiang/pharmacies/master/json/points.json"
        }
        var method: Method {
            .get
        }
        var task: Task {
            .requestPlain
        }
    }
}
