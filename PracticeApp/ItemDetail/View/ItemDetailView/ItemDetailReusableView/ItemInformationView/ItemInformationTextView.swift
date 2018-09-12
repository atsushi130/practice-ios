//
//  ItemInformationTextView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/13.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
final class ItemInformationTextView: UIView, NibDesignable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    @IBInspectable
    var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    @IBInspectable
    var iconImage: UIImage? {
        get { return self.iconImageView.image }
        set { self.iconImageView.image = newValue }
    }
    
    @IBInspectable
    var text: String? {
        get { return self.textLabel.text }
        set { self.textLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}
