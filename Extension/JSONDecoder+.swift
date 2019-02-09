//
//  JSONDecoder+.swift
//  Extension
//
//  Created by Atsushi Miyake on 2019/02/09.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    public static var snakeCaseDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
