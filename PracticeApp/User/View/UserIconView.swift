//
//  UserIconView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

@IBDesignable final class UserIconView: UIView {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBInspectable
    var image: UIImage? {
        get { return self.imageView.image }
        set { self.imageView.image = newValue }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
