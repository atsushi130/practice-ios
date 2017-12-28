//
//  LoginButton.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable final class LoginButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get { return self.layer.borderColor?.ex.uiColor }
        set { self.layer.borderColor = newValue?.cgColor }
    }
}
