//
//  ItemNameView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/03.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
public final class ItemNameView: UIView, NibDesignable {
    
    @IBOutlet private weak var mainNameLabel: UILabel!
    @IBOutlet private weak var subNameLabel:  UILabel!
 
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
    
    public func bind(name: (main: String, sub: String)) {
        self.mainNameLabel.text = name.main
        self.subNameLabel.text  = name.sub
    }
}
