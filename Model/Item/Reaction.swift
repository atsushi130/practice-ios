//
//  Reaction.swift
//  Model
//
//  Created by Atsushi Miyake on 2018/09/11.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation

public enum Reaction {
    
    case wants(state: Bool, count: Int)
    case haves(state: Bool, count: Int)
    
    public var state: Bool {
        switch self {
        case let .wants(state, _): return state
        case let .haves(state, _): return state
        }
    }
    
    public var count: Int {
        switch self {
        case let .wants(_, count): return count
        case let .haves(_, count): return count
        }
    }
    
    mutating public func update(state: Bool) {
        switch self {
        case let .wants(_, count): self = .wants(state: state, count: count)
        case let .haves(_, count): self = .haves(state: state, count: count)
        }
    }
    
    mutating public func `switch`() {
        switch self {
        case let .wants(state, count): self = .wants(state: !state, count: count)
        case let .haves(state, count): self = .haves(state: !state, count: count)
        }
    }
    
    mutating public func turnOn() {
        switch self {
        case let .wants(_, count): self = .wants(state: true, count: count)
        case let .haves(_, count): self = .haves(state: true, count: count)
        }
    }
    
    mutating public func turnOff() {
        switch self {
        case let .wants(_, count): self = .wants(state: false, count: count)
        case let .haves(_, count): self = .haves(state: false, count: count)
        }
    }
}

public final class Reactions: Decodable {
    public var wants: Reaction
    public var haves: Reaction
    
    public static var `default`: Reactions {
        return Reactions()
    }
    
    public typealias ReactionType = ReactionCodingKeys
    public enum ReactionCodingKeys: String, CodingKey {
        case wants
        case haves
        public var title: String {
            switch self {
            case .wants: return "wantしている人"
            case .haves: return "haveしている人"
            }
        }
    }
    
    fileprivate enum ReactionValueCodingKeys: String, CodingKey {
        case state
        case count
    }
    
    private init() {
        self.wants = Reaction.wants(state: false, count: 0)
        self.haves = Reaction.haves(state: false, count: 0)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ReactionCodingKeys.self)
        let wantsValues = try values.nestedContainer(keyedBy: ReactionValueCodingKeys.self, forKey: .wants)
        let havesValues = try values.nestedContainer(keyedBy: ReactionValueCodingKeys.self, forKey: .haves)
        
        self.wants = Reaction.wants(
            state: try wantsValues.decode(Bool.self, forKey: .state),
            count: try wantsValues.decode(Int.self, forKey: .count)
        )
        self.haves = Reaction.haves(
            state: try havesValues.decode(Bool.self, forKey: .state),
            count: try havesValues.decode(Int.self, forKey: .count)
        )
    }
    
    public func `switch`(of reactionType: ReactionType) {
        switch reactionType {
        case .wants:
            self.wants.switch()
            self.haves.turnOff()
        case .haves:
            self.haves.switch()
            self.wants.turnOff()
        }
    }
}
