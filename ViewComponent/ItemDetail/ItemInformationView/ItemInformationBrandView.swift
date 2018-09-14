//
//  ItemInformationBrandView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/13.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
final class ItemInformationBrandView: UIView, NibDesignable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}
