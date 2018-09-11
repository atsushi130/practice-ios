//
//  Reaction.swift
//  Model
//
//  Created by Atsushi Miyake on 2018/09/11.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation

public final class Reaction: Decodable {
    
    public var wants: (state: Bool, count: Int)
    public var haves: (state: Bool, count: Int)
    
    private enum CodingKeys: String, CodingKey {
        case wants
        case haves
    }
    
    private enum NestedKeys: String, CodingKey {
        case state
        case count
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let wants = try values.nestedContainer(keyedBy: NestedKeys.self, forKey: .wants)
        self.wants = (state: try wants.decode(Bool.self, forKey: .state), count: try wants.decode(Int.self, forKey: .count))
        
        let haves = try values.nestedContainer(keyedBy: NestedKeys.self, forKey: .haves)
        self.haves = (state: try haves.decode(Bool.self, forKey: .state), count: try haves.decode(Int.self, forKey: .count))
    }
}
