//
//  PasswordValidateModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

struct PasswordValidateViewModel: LoginFieldValidateViewModelable {
    
    typealias Value = String
    
    static let shared = PasswordValidateViewModel()
    private init() {}
    
    enum Pattern: String {
        // the keyword is 8 half-width alphanumeric or more.
        case `default` = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d]{8,}$"
        // the keyword is 8 half-width alphanumeric and symbol or more.
        case withSymbol = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
    }
    
    func validate(_ password: String) -> Bool {
        // the keyword is 8 half-width alphanumeric and symbol or more.
        return password.ex.isMatch(pattern: Pattern.withSymbol.rawValue)
    }
}
