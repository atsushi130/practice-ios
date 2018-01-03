//
//  ItemNameView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/03.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ItemNameView: UIView {
    
    @IBOutlet private weak var mainNameLabel: UILabel!
    @IBOutlet private weak var subNameLabel:  UILabel!
    
    func bind(name: (main: String, sub: String)) {
        self.mainNameLabel.text = name.main
        self.subNameLabel.text  = name.sub
    }
}
