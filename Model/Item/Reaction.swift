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
        case let .wants(_, count):
            self = .wants(state: state, count: count)
        case let .haves(_, count):
            self = .haves(state: state, count: count)
        }
    }
}
