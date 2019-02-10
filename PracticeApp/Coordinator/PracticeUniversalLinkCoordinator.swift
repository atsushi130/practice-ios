//
//  PracticeUniversalLinkCoordinator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2019/02/09.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import UniversalLinkCoordinatorKit
import CoordinatorKit

final class PracticeUniversalLinkCoordinator: UniversalLinkCoordinator, Coordinator {
    
    static let shared = PracticeUniversalLinkCoordinator()
    var viewController: UIViewController? = nil

    let router = UniversalLinkRouter<UniversalLink>()
    
    typealias Route = (universalLink: UniversalLink, context: UniversalLinkContext)
    enum UniversalLink: String, UniversalLinkable {
        static var scheme: String { return "com.github.atsush130.practice" }
        case items     = "/items"
        case item      = "/items/:item_id"
        case mySumally = "/mysumally"
    }
    
    func transition(to route: Route) {
        switch route.universalLink {
        case .items:
            self.mainTabController?.coordinator.transition(to: .itemList)
        case .item:
            guard let itemId: String = route.context.parameters["item_id"] else { return }
            let itemCoordinator = self.mainTabController?.itemViewController.viewModel.coordinator
            itemCoordinator?.transition(to: .detail(itemId: itemId))
        case .mySumally:
            self.mainTabController?.coordinator.transition(to: .mySumally)
        }
    }
}
