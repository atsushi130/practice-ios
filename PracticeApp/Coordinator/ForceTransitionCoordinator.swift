//
//  ForceTransitionCoordinator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoordinatorKit
import Connectable
import Data

final class ForceTransitionCoordinator: Coordinator, Inputable {
    
    static let shared = ForceTransitionCoordinator()
    var viewController: UIViewController? = nil
    
    typealias Route = ForceTransitionRoute

    func transition(to route: Route) {
        switch route {
        case .logout:
            // transition to login view.
            break
        case .updateRequired:
            // let forceUpdateViewController = ForceUpdateViewController.instantiate()
            // UIApplication.shared.keyWindow?.rootViewController = forceUpdateViewController
            break
        case .ban:
            // let banViewController = BanViewController.instantiate()
            // UIApplication.shared.keyWindow?.rootViewController = banViewController
            break
        }
    }
}

// MARK: - Input
extension InputSpace where Definer: ForceTransitionCoordinator {
    var transition: AnyObserver<ForceTransitionCoordinator.Route> {
        return AnyObserver<ForceTransitionCoordinator.Route> { event in
            if case .next(let forceTransitionRoute) = event {
                self.definer.transition(to: forceTransitionRoute)
            }
        }
    }
}
