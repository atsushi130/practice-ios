//
//  Item.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

final class Item: Itemable {
    let id: String
    let name:    String
    let subName: String
    var isOn: (wants: Bool, haves: Bool)
    var count: (wants: Int, haves: Int)
    
    init(id: String, name: String, subName: String, isOn: (wants: Bool, haves: Bool), count: (wants: Int, haves: Int)) {
        self.id      = id
        self.name    = name
        self.subName = subName
        self.isOn    = isOn
        self.count   = count
    }
}
