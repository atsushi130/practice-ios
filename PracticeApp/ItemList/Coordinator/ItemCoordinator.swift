//
//  ItemCoordinator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import CoordinatorKit

struct ItemCoordinator: Coordinator {
    
    weak var viewController: UIViewController?
    
    enum Route {
        case detail
    }
    
    func transition(to route: ItemCoordinator.Route) {
        switch route {
        case .detail:
            let vc = ItemDetailViewController.instantiate()
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
