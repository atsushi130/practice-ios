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
    public var reaction: Reaction
}
