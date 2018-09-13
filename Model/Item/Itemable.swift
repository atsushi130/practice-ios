//
//  Itemable.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

protocol Itemable {
    var name: String { get }
    var subName: String { get }
    var isOn: (wants: Bool, haves: Bool) { get }
    var count: (wants: Int, haves: Int) { get }
}
