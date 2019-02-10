//
//  PracticeEndpoint.swift
//  Data
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import Moya

protocol PracticeEndpoint: TargetType {}

extension PracticeEndpoint {
    
    var baseURL: URL {
        return URL(string: "localhost:8080")!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return [
            "Cookie": "",
            "User-Agent": "practice-ios/\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)"
        ]
    }
}
