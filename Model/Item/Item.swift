//
//  Item.swift
//  Model
//
//  Created by Atsushi Miyake on 2018/09/11.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation

public final class Item: Decodable {
    public let id: String
    public let name: String
    public let subName: String
    public var reaction: (wants: Reaction, haves: Reaction)
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let reactionValues = try values.nestedContainer(keyedBy: ReactionCodingKeys.self, forKey: .reaction)
        let wantsValues = try reactionValues.nestedContainer(keyedBy: ReactionValueCodingKeys.self, forKey: .wants)
        let havesValues = try reactionValues.nestedContainer(keyedBy: ReactionValueCodingKeys.self, forKey: .haves)
        
        let wants = Reaction.wants(
            state: try wantsValues.decode(Bool.self, forKey: .state),
            count: try wantsValues.decode(Int.self, forKey: .count)
        )
        let haves = Reaction.haves(
            state: try havesValues.decode(Bool.self, forKey: .state),
            count: try havesValues.decode(Int.self, forKey: .count)
        )
        
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.subName = try values.decode(String.self, forKey: .subName)
        self.reaction = (wants: wants, haves: haves)
    }
}

// MARK: - Behavior
public extension Item {
    public func updateReactionState(wants: Bool, haves: Bool) {
        self.reaction.wants.update(state: wants)
        self.reaction.haves.update(state: haves)
    }
}

// MARK: - Item CodingKeys
extension Item {
    fileprivate enum CodingKeys: String, CodingKey {
        case id
        case name
        case subName
        case reaction
    }
}

// MARK: - Reaction CodingKeys
extension Item {
    
    fileprivate enum ReactionCodingKeys: String, CodingKey {
        case wants
        case haves
    }
    
    fileprivate enum ReactionValueCodingKeys: String, CodingKey {
        case state
        case count
    }
}
