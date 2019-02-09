//
//  PracticeUniversalLinkCoordinator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2019/02/09.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import UniversalLinkCoordinatorKit

final class PracticeUniversalLinkCoordinator: UniversalLinkCoordinator {
    
    static let shared = PracticeUniversalLinkCoordinator()
    private init() {}
    
    let router = UniversalLinkRouter<UniversalLink>()
    
    typealias Route = (universalLink: UniversalLink, context: UniversalLinkContext)
    enum UniversalLink: String, UniversalLinkable {
        static var scheme: String { return "com.github.atsush130.practice" }
        case items = "/items/:item_id"
    }
    
    func transition(to route: Route) {
        switch route.universalLink {
        case .items:
            guard let itemId: String = route.context.parameters["item_id"] else { return }
            print("itemId: \(itemId)")
        }
    }
}