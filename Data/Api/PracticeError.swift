//
//  PracticeError.swift
//  Data
//
//  Created by Atsushi Miyake on 2019/02/09.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public enum PracticeError: Error {

    case internalError
    case jsonDecodeError(error: Error)
    case specificError(message: String, code: Int?)
    
    public var message: String {
        switch self {
        case .internalError:
            return "internal error"
        case .jsonDecodeError:
            return "json decode error"
        case .specificError(let message, _):
            return message
        }
    }
    
    public var code: Int? {
        switch self {
        case .internalError, .jsonDecodeError:
            return 0
        case .specificError(_, let code):
            return code
        }
    }
}

struct RequestError: Decodable {
    let message: String
    let code: Int?
}
