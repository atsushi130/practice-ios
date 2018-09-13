//
//  ItemDetail.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation

public struct ItemDetail: Itemable {
    public let name: String
    public let subName: String
    public var isOn: (wants: Bool, haves: Bool)
    public var count: (wants: Int, haves: Int)
    public let users: (wants: [User], haves: [User])
    public let brand: Brand?
    public let categories: [Category]
    public let registrant: User
    public let createAt: Date
    public let associateItems: [Item]
}
