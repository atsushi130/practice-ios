//
//  FunButton.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

@IBDesignable final class FollowButton: UIButton {
    
    @IBInspectable
    var title: String {
        get { return self.title }
        set { self.title = newValue }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get { return self.layer.borderColor!.ex.uiColor }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
}
