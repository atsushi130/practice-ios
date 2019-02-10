//
//  ForceTransitionRoute.swift
//  Data
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import Moya

public enum ForceTransitionRoute {
    
    case logout
    case updateRequired
    case ban
    
    init?(statusCode: Int, error: RequestError) {
        switch statusCode {
        case 401:
            self = .logout
        case 403:
            guard let code = error.code else { return nil }
            switch code {
            case 1: self = .logout
            case 2: self = .updateRequired
            case 3: self = .ban
            default: return nil
            }
        default:
            return nil
        }
    }
}
