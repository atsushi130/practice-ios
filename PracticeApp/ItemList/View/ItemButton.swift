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
    fileprivate let animationDuration = 0.5
    
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
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.animationView.transform = CGAffineTransform.identity
            }) { _ in }
            
        case false:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
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
        return self.base.button.rx.controlEvent(controlEvent).asDriver().throttle(self.base.animationDuration)
    }
}
