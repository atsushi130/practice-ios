//
//  UserIconView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
public final class UserIconView: UIView, NibDesignable {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBInspectable
    public var image: UIImage? {
        get { return self.imageView.image }
        set { self.imageView.image = newValue }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}
