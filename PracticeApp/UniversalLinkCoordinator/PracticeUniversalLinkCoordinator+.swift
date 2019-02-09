//
//  PracticeUniversalLinkCoordinator+.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2019/02/10.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import UIKit

extension PracticeUniversalLinkCoordinator {
    var mainTabController: MainTabController? {
        if let mainTabController = UIApplication.shared.keyWindow?.rootViewController as? MainTabController {
            return mainTabController
        }
        if let mainTabController = UIApplication.shared.keyWindow?.rootViewController?.tabBarController as? MainTabController {
            return mainTabController
        }
        return nil
    }
}
