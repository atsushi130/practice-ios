//
//  LoginViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var loginView: LoginView!
    
    private let disposeBag     = DisposeBag()
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observe()
    }
    
    private func observe() {
        
        self.loginView.rx.account.value
            .map(AccountValidateViewModel.shared.validate)
            .bind(to: self.loginView.rx.account.isValidated)
            .disposed(by: self.disposeBag)
        
        self.loginView.rx.password.value
            .map(PasswordValidateViewModel.shared.validate)
            .bind(to: self.loginView.rx.password.isValidated)
            .disposed(by: self.disposeBag)
        
        self.loginView.rx.login
            .subscribe(onNext: self.loginViewModel.login(account:password:))
            .disposed(by: self.disposeBag)
        
        self.loginViewModel.rx.login.subscribe(
            onNext:  { _ in
                print("perform segue")
            },
            onError: { _ in /* api request error */ }
        ).disposed(by: self.disposeBag)
    }
}
