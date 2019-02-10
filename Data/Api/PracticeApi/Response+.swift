//
//  Response+.swift
//  Data
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import Moya

extension Response {
    var requestError: RequestError? {
        return try? self.map(RequestError.self, using: .snakeCaseDecoder)
    }
}
