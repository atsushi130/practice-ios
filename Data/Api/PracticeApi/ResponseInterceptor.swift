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
    func intercept(response: Response) -> Observable<Void>?
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
    
    func intercept(response: Response) -> Observable<Void>? {
        switch response.statusCode {
        case 200...226: return .just(())
        default: return nil
        }
    }
}

final class FailureResponseInterceptor: ResponseInterceptor {
    
    static let shared = FailureResponseInterceptor()
    private init() {}
    
    func intercept<T>(response: Response) -> Observable<T>? where T : Decodable {
        return self.failureHandle(response: response)
    }
    
    func intercept(response: Response) -> Observable<Void>? {
        return self.failureHandle(response: response)
    }
    
    private func failureHandle<T>(response: Response) -> Observable<T>? {
        switch response.statusCode {
        case 400...600:
            guard let error = response.requestError else { return .error(PracticeError.internalError) }
            if let route = ForceTransitionRoute(statusCode: response.statusCode, error: error) {
                PracticeApi.shared.triggerForceTransition.onNext(route)
                return .empty()
            } else {
                return .error(PracticeError.specificError(message: error.message, code: error.code))
            }
        default: return nil
        }
    }
}
