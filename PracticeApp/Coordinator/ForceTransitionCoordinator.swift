//
//  ForceTransitionCoordinator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import CoordinatorKit

final class ForceTransitionCoordinator: Coordinator {
    
    var viewController: UIViewController? = nil
    
    enum Route {
        case logout
        case updateRequired
        case ban
    }
    
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
