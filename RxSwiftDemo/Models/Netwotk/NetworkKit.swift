//
//  NetworkKit.swift
//  RxSwiftDemo
//
//  Created by Archie on 2020/5/4.
//  Copyright © 2020 Archie. All rights reserved.
//

import Alamofire
import Moya
import RxSwift

final class NetworkKit {
    static let shared: NetworkKit = NetworkKit()
    
    private let provider: MoyaProvider<MultiTarget> = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        return MoyaProvider<MultiTarget>(session: session, plugins: [])
    }()
    
    private init() {}
    
    func request<Request: APITargetType>(_ request: Request) -> Single<Request.ResponseType> {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return provider.rx.request(MultiTarget(request))
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .filterSuccessfulStatusCodes()
            .map(Request.ResponseType.self, atKeyPath: nil, using: decoder, failsOnEmptyData: false)
    }
}

protocol APITargetType: TargetType {
    associatedtype ResponseType: Decodable
    func request() -> Single<Self.ResponseType>
}

extension APITargetType {
    var sampleData: Data {
        Data()
    }
    
    func request() -> Single<Self.ResponseType> {
        NetworkKit.shared.request(self)
    }
}
