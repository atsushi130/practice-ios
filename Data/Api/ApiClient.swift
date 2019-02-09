//
//  ApiClient.swift
//  Data
//
//  Created by Atsushi Miyake on 2018/09/10.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public final class ApiClient {
    private init() {}
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
    }
}
