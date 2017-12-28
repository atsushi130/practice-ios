//
//  LoginView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginView: UIView {
    
    @IBOutlet fileprivate weak var accountField:  LoginField!
    @IBOutlet fileprivate weak var passwordField: LoginField!
    @IBOutlet fileprivate weak var loginButton:   LoginButton!
    
    private let disposeBag     = DisposeBag()
    fileprivate let loginEvent = PublishSubject<(account: String, password: String)>()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.observe()
    }
    
    func observe() {
        
        // when editing end, move the forcus to password field.
        self.accountField.rx.controlEvent(.editingDidEndOnExit).subscribe({ [weak self] _ in
            self?.passwordField.becomeFirstResponder()
        }).disposed(by: self.disposeBag)
        
        // when editing end, close keyboard.
        self.passwordField.rx.controlEvent(.editingDidEndOnExit).subscribe({ [weak self] _ in
            self?.passwordField.resignFirstResponder()
        }).disposed(by: self.disposeBag)
        
        let accountValidated  = self.accountField.isValidated.asObservable()
        let passwordValidated = self.passwordField.isValidated.asObservable()
        
        // bind it to login button whether each field value was validated.
        Observable.combineLatest(passwordValidated, accountValidated) { return $0 && $1 }.bind(to: self.loginButton.rx.isEnabled).disposed(by: self.disposeBag)
    }
    
    @IBAction private func login() {
        let account = (account: self.accountField.value, password: self.passwordField.value)
        self.loginEvent.onNext(account)
    }
}

// MARK: - Reactive
extension Reactive where Base: LoginView {
    
    var account: (value: Observable<String>, isValidated: Binder<Bool>) {
        return (value: self.base.accountField.rx.value, isValidated: self.base.accountField.rx.isValidated)
    }
    
    var password: (value: Observable<String>, isValidated: Binder<Bool>) {
        return (value: self.base.passwordField.rx.value, isValidated: self.base.passwordField.rx.isValidated)
    }
    
    var login: Observable<(account: String, password: String)> { return self.base.loginEvent }
}
