//
//  ItemDetailCoordinator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/10.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import CoordinatorKit

struct ItemDetailCoordinator: Coordinator {
    
    weak var viewController: UIViewController?
    
    enum Route {
        case userList(reactionType: ReactionView.ReactionType)
        case detail
        
        var viewController: UIViewController {
            switch self {
            case .userList: return UserListViewController.instantiate()
            case .detail:   return ItemDetailViewController.instantiate()
            }
        }
        
        var navigationTitle: String {
            switch self {
            case let .userList(reactionType): return reactionType.title
            case .detail: return ""
            }
        }
    }
    
    func transition(to route: Route) {
        let viewController = route.viewController
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
        viewController.navigationItem.title = route.navigationTitle
    }
}
