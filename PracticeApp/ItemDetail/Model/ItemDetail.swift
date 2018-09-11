//
//  ItemDetail.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import Model

struct ItemDetail: Itemable {
    let name: String
    let subName: String
    var isOn: (wants: Bool, haves: Bool)
    var count: (wants: Int, haves: Int)
    let users: (wants: [User], haves: [User])
    let brand: Brand?
    let categories: [Category]
    let registrant: User
    let createAt: Date
    let associateItems: [Item]
}
