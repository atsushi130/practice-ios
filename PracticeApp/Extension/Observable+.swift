//
//  Observable+.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftExtensions
import Data

extension Observable {
    
    func asDriverWithPracticeErrorAlert(on viewController: UIViewController) -> Driver<Element> {
        return self.catchError { [weak viewController] error in
            if let practiceError = error as? PracticeError {
                let alert = UIAlertController.okAlertController(title: practiceError.message, message: "")
                viewController?.present(alert, animated: true)
            }
            return .empty()
        }
        .asDriverIgonringError()
    }
}
