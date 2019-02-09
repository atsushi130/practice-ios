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

protocol ResponseInterceptor {
    func intercept<T>(response: Response) -> Observable<T>? where T: Decodable
}
