//
//  LoginFieldValidateModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

protocol LoginFieldValidateViewModelable {
    associatedtype Value
    func validate(_ value: Value) -> Bool
}
