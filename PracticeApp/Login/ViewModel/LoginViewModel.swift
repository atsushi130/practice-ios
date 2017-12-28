//
//  LoginViewModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import RxSwift
import RxCocoa

struct LoginViewModel {
    
    private let disposeBag     = DisposeBag()    
    fileprivate let loginEvent = PublishSubject<Account>()
    
    func login(account: String, password: String) {
        let account = Account(account: account, password: password)
        
        // execute api request
        LoginApi.shared.login(account: account).subscribe(
            onNext: { _ in
                self.loginEvent.onNext(account)
                self.loginEvent.onCompleted()
            },
            onError: { error in
                self.loginEvent.onError(error)
            }
        ).disposed(by: self.disposeBag)
    }
}

extension LoginViewModel: ReactiveCompatible {}
extension Reactive where Base == LoginViewModel {
    var login: Observable<Account> { return self.base.loginEvent }
}
