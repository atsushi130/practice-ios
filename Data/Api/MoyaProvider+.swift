//
//  MoyaProvider+.swift
//  Data
//
//  Created by Atsushi Miyake on 2019/02/09.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxMoya

extension Reactive where Base: MoyaProviderType {
    
    func request<T>(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<T> where T: Decodable {
        return self.request(token, callbackQueue: callbackQueue)
            .asObservable()
            .intercept()
    }
    
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<Void> {
        return self.request(token, callbackQueue: callbackQueue)
            .asObservable()
            .intercept()
    }
}
