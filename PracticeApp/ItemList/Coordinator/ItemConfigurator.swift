//
//  ItemConfigurator.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import CoordinatorKit

struct ItemConfigurator: Configurator {
    typealias VC = ItemViewController
    static func configure(with vc: ItemConfigurator.VC, dependency: ItemConfigurator.VC.Dependency) {
        let coordinator = ItemCoordinator()
        vc.viewModel = ItemViewModel(coordinator: coordinator)
    }
}
