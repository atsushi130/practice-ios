//
//  ResponseInterceptor.swift
//  Data
//
//  Created by Atsushi Miyake on 2019/02/09.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Extension

enum PracticeApiResponseInterceptor: Swift.CaseIterable {
    case success
    case failure
    var interceptor: ResponseInterceptor {
        switch self {
        case .success: return SuccessResponseInterceptor.shared
        case .failure: return FailureResponseInterceptor.shared
        }
    }
}

protocol ResponseInterceptor {
    func intercept<T>(response: Response) -> Observable<T>? where T: Decodable
}

final class SuccessResponseInterceptor: ResponseInterceptor {
    
    static let shared = SuccessResponseInterceptor()
    private init() {}
    
    func intercept<T>(response: Response) -> Observable<T>? where T : Decodable {
        switch response.statusCode {
        case 200...226:
            do {
                let decoded = try response.map(T.self, using: .snakeCaseDecoder)
                return .just(decoded)
            } catch {
                return .error(PracticeError.jsonDecodeError(error: error))
            }
        default: return nil
        }
    }
}

final class FailureResponseInterceptor: ResponseInterceptor {
    
    static let shared = FailureResponseInterceptor()
    private init() {}
    
    func intercept<T>(response: Response) -> Observable<T>? where T : Decodable {
        switch response.statusCode {
        case 400...600:
            guard let error = try? response.map(RequestError.self, using: .snakeCaseDecoder) else {
                return .error(PracticeError.internalError)
            }
            return .error(PracticeError.specificError(message: error.message, code: error.code))
        default: return nil
        }
    }
}
