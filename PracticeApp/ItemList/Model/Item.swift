//
//  Item.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

struct Item: Itemable {
    let name:    String
    let subName: String
    var isOn: (wants: Bool, haves: Bool)
    var count: (wants: Int, haves: Int)
}
