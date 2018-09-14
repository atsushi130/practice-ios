//
//  ItemActionView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/03.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
public final class ItemActionView: UIView, NibDesignable {
    
    @IBOutlet private weak var google: UIButton!
    @IBOutlet private weak var folder: UIButton!
    @IBOutlet private weak var sell:   UIButton!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}

