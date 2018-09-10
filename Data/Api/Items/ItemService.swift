//
//  ItemService.swift
//  Data
//
//  Created by Atsushi Miyake on 2018/09/10.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import Model

public extension ApiClient {
    public final class ItemService {
        public static let shared = ItemService()
        private init() {}
        
        enum Endpoint {
            case fetchAll
        }
    }
}

extension ApiClient.ItemService.Endpoint {
    
    var path: String {
        return Bundle.main.path(forResource: "items", ofType: "json")!
    }
    
    var url: URL {
        return URL(fileURLWithPath: self.path)
    }
}

public extension ApiClient.ItemService {
    public func fetchAll() -> Observable<[Model.Item]> {
        let data = try! Data(contentsOf: Endpoint.fetchAll.url)
        let items = try! JSONDecoder().decode([Model.Item].self, from: data)
        return Observable.just(items)
    }
}
