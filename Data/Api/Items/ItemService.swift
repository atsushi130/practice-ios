//
//  ItemService.swift
//  Data
//
//  Created by Atsushi Miyake on 2018/09/10.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Model

public extension PracticeApi {
    
    // MARK: - Service
    public final class ItemService: PracticeApiService {
        fileprivate static let shared = ItemService()
        private init() {}
        
        let provider = MoyaProvider<Endpoint>(stubClosure: MoyaProvider<Endpoint>.immediatelyStub)
        
        // MARK: - Endpoint
        enum Endpoint: PracticeEndpoint {
            case fetchAll
        }
    }
    
    public static var items: ItemService {
        return ItemService.shared
    }
}

extension PracticeApi.ItemService.Endpoint {
    
    var path: String {
        switch self {
        case .fetchAll:
            return "/items"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAll:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchAll:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .fetchAll:
            let path = Bundle.main.path(forResource: "items", ofType: "json")!
            let url = URL(fileURLWithPath: path)
            return try! Data(contentsOf: url)
        }
    }
}

// MARK: Interface
public extension PracticeApi.ItemService {
    
    /// Fetch latest items
    /// - Returns: all items
    public func latest() -> Observable<[Item]> {
        return self.provider.rx.request(.fetchAll)
    }
}
