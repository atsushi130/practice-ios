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
        case detail(itemId: String)
    }
    
    func transition(to route: ItemCoordinator.Route) {
        switch route {
        case .detail(let itemId):
            let dependency = ItemDetailViewController.Dependency(itemId: itemId)
            let vc = ItemDetailViewController.instantiate(with: dependency)
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
