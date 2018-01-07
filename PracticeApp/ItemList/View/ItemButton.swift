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
    @IBOutlet weak var animationView:      UIView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var typeLabel:  UILabel!
    
    @IBOutlet fileprivate weak var reactionView: ReactionView!
    
    private let disposeBag = DisposeBag()
    
    var isOn: Bool = false {
        didSet { self.reactionView.isOn = self.isOn }
    }
    
    var reactionType: ReactionView.ReactionType = ReactionView.ReactionType.wants {
        didSet { self.reactionView.reactionType = self.reactionType }
    }
}

extension Reactive where Base: ItemButton {
    
    func controlEvent(_ controlEvent: UIControlEvents) -> Driver<Void> {
        return self.base.button.rx.controlEvent(controlEvent).asDriver().throttle(self.base.reactionView.animationDuration)
    }
}
