//
//  Userable.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

protocol Userable {
    var name: String { get }
    var profile: String { get }
    var follow: Int { get }
    var follower: Int { get }
}
