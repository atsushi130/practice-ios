//
//  LoginApi.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import RxSwift

struct LoginApi {
    
    static let shared = LoginApi()
    private init() {}
    
    func login(account: Account) -> Observable<Account> {
        return Observable.create { observer in
            observer.onNext(account)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
