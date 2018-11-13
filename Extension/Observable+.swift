//
//  Observable+.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftExtensions

public extension Observable {
    
    public var discarded: Observable<()> {
        return self.fill(())
    }
    
    public func fill<A>( _ value: A) -> Observable<A> {
        return self.map { _ in value }
    }
    
    public func asDriverIgonringError() -> Driver<Element> {
        return self.asDriver(onErrorDriveWith: .empty())
    }
    
    public func asDriverWithErrorAlert(title: String = "", message: String = "", on viewController: UIViewController) -> Driver<Element> {
        return self.asDriver(onErrorRecover: { [weak viewController] _ in
            let alert = UIAlertController.okAlertController(title: title, message: message)
            viewController?.present(alert, animated: true, completion: nil)
            return .empty()
        })
    }
}
