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
        case item = "/items/:item_id"
    }
    
    func transition(to route: Route) {
        switch route.universalLink {
        case .item:
            guard let itemId: String = route.context.parameters["item_id"] else { return }
            let itemCoordinator = self.mainTabController?.itemViewController.viewModel.coordinator
            itemCoordinator?.transition(to: .detail(itemId: itemId))
        }
    }
}
