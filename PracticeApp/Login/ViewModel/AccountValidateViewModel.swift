//
//  AccountValidateModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

struct AccountValidateViewModel: LoginFieldValidateViewModelable {
    
    typealias Value = String
    
    static let shared = AccountValidateViewModel()
    private init() {}
    
    func validate(_ account: String) -> Bool {
        // number or alphabet or conformed symbol
        return !self.exists(account) && account.ex.isMatch(pattern: "^[0-9|a-zA-Z|(?=.*[-_])]*$")
    }
    
    func exists(_ account: String) -> Bool {
        return false
    }
}
