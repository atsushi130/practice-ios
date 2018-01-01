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
    
    @IBOutlet fileprivate weak var button:    UIButton!
    @IBOutlet private weak var imageView:     UIImageView!
    @IBOutlet weak var animationView:         UIView!
    @IBOutlet private weak var countLabel:    UILabel!
    @IBOutlet private weak var typeLabel:     UILabel!
    
    private let disposeBag = DisposeBag()
    
    fileprivate struct Const {
        typealias OnOff = (on: CGFloat, off: CGFloat)
        static let animationDuration     = 0.45
        static let springDamping: OnOff  = (on: 0.4, off: 1.0)
        static let springVelocity: OnOff = (on: 0.0, off: 1.0)
        static let options: UIViewAnimationOptions = .curveEaseIn
    }
    
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
        didSet {
            self.changeAnimation()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.animationView.backgroundColor    = UIColor.theme
        self.animationView.layer.cornerRadius = self.animationView.frame.size.width.ex.half
    }
    
    private func changeImage() {
        self.imageView.image = UIImage(named: self.buttonType.rawValue + "_mark")
    }
    
    private func changeAnimation() {

        switch self.isOn {
        case true:
            UIView.animate(withDuration: Const.animationDuration,
                           delay: 0,
                           usingSpringWithDamping: Const.springDamping.on,
                           initialSpringVelocity:  Const.springVelocity.on,
                           options: Const.options,
                           animations: {
                self.animationView.transform = CGAffineTransform.identity
            }) { _ in }
            
        case false:
            UIView.animate(withDuration: Const.animationDuration,
                           delay: 0,
                           usingSpringWithDamping: Const.springDamping.off,
                           initialSpringVelocity:  Const.springVelocity.off,
                           options: Const.options,
                           animations: {
                self.animationView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }) { _ in }
        }
    }
    
    private func changeTypeLabel() {
        self.typeLabel.text = self.buttonType.rawValue
    }
}

extension Reactive where Base: ItemButton {
    
    func controlEvent(_ controlEvent: UIControlEvents) -> Driver<Void> {
        return self.base.button.rx.controlEvent(controlEvent).asDriver().throttle(ItemButton.Const.animationDuration)
    }
}
