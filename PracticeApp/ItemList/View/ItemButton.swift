//
//  ItemButton.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ItemButton: UIView {
    
    @IBOutlet fileprivate weak var button: UIButton!
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
    
    var isOn = false {
        didSet { self.changeImage() }
    }
    
    private var suffix: String {
        get { return self.isOn ? "_on" : "_off" }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func changeImage() {
        self.imageView.image = UIImage(named: self.buttonType.rawValue + self.suffix)
    }
    
    private func changeTypeLabel() {
        self.typeLabel.text = self.buttonType.rawValue
    }
}

extension Reactive where Base: ItemButton {
    
    var tap: ControlEvent<Void> {
        return self.base.button.rx.tap
    }
    
    func controlEvent(_ controlEvent: UIControlEvents) -> Driver<Void> {
        return self.base.button.rx.controlEvent(controlEvent).asDriver()
    }
}
