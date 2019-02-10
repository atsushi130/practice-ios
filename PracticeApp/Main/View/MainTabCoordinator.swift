//
//  MainTabCoordinator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import CoordinatorKit

struct MainTabCoordinator: Coordinator {
    
    weak var viewController: UIViewController?
    private var mainTabController: MainTabController? {
        return self.viewController as? MainTabController
    }
    
    enum Route {
        case itemList
        case mySumally
    }
    
    func transition(to route: Route) {
        switch route {
        case .itemList:
            self.mainTabController?.selectedIndex = 0
        case .mySumally:
            self.mainTabController?.selectedIndex = 1
        }
    }
}
