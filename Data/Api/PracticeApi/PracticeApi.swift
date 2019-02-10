//
//  PracticeApi.swift
//  Data
//
//  Created by Atsushi Miyake on 2018/09/10.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import Connectable
import Moya

public final class PracticeApi: Outputable {
    public static let shared = PracticeApi()
    private init() {}
    let triggerForceTransition = PublishSubject<ForceTransitionRoute>()
}

public extension OutputSpace where Definer: PracticeApi {
    public var forceTransition: Observable<ForceTransitionRoute> {
        return self.definer.triggerForceTransition.asObservable()
    }
}

extension Observable where Element: Response {
    
    @inline(never)
    func intercept<T>() -> Observable<T> where T: Decodable {
        return self.flatMap { response -> Observable<T> in
                return PracticeApiResponseInterceptor.allCases
                    .map { $0.interceptor }
                    .compactMap { interceptor -> Observable<T>? in
                        interceptor.intercept(response: response)
                    }
                    .first!
            }
            .debugLogIfNeeded()
    }
    
    @inline(never)
    func intercept() -> Observable<Void> {
        return self.flatMap { response -> Observable<Void> in
                return PracticeApiResponseInterceptor.allCases
                    .map { $0.interceptor }
                    .compactMap { interceptor -> Observable<Void>? in
                        interceptor.intercept(response: response)
                    }
                    .first!
            }
            .debugLogIfNeeded()
    }
}

extension Observable {
    @inline(__always)
    fileprivate func debugLogIfNeeded() -> Observable<Element> {
        #if RELEASE || BETA
        return self
        #else
        guard ProcessInfo.processInfo.environment["API_DEBUG_MODE"] != nil else { return self }
        return self.do(onNext: { value in
            print("request success: \(value)")
        }, onError: { error in
            print("request error: \(error)")
        })
        #endif
    }
}
