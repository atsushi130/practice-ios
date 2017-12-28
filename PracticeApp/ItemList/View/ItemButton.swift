//
//  ItemButton.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ItemButton: UIView {
    
    @IBOutlet private weak var imageView:  UIImageView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var typeLabel:  UILabel!
    
    enum ButtonType: String {
        case wants = "wants"
        case haves = "haves"
    }
    
    var buttonType: ButtonType = .wants {
        didSet {
            self.changeImage()
            self.changeTypeLabel()
        }
    }
    
    private var isOn = false {
        didSet { self.changeImage() }
    }
    
    private var suffix: String {
        get { return self.isOn ? "_on" : "_off" }
    }
    
    private func changeImage() {
        self.imageView.image = UIImage(named: self.buttonType.rawValue + self.suffix)
    }
    
    private func changeTypeLabel() {
        self.typeLabel.text = self.buttonType.rawValue
    }
    
    @IBAction func tap() {
        self.isOn = !self.isOn
    }
}
