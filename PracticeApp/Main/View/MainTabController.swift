//
//  MainViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/01.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import UIFontComplete

final class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.setupNavigationBar()
        self.setupTabBar()
        self.delegate = self
    }
    
    private func setupNavigationBar() {
        guard let font = UIFont(font: .hiraginoSansW6, size: 18.5) else { return }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: font]
    }
    
    private func setupTabBar() {
        UITabBar.appearance().tintColor               = UIColor.theme
        UITabBar.appearance().unselectedItemTintColor = UIColor.ex.hex(string: "A1A1A1")
        guard let font = UIFont(font: .hiraginoSansW6, size: 10) else { return }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: UIColor.theme], for: .selected)
    }
}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case 0: viewController.navigationController?.navigationBar.topItem?.title = "ホーム"
        case 1: viewController.navigationController?.navigationBar.topItem?.title = "Atsushi"
        default: break
        }
    }
}
