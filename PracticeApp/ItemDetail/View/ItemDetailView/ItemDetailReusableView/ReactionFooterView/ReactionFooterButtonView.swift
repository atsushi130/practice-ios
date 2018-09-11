//
//  ReactionFooterButtonView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/03.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
final class ReactionFooterButtonView: UIView {
    
    @IBOutlet fileprivate weak var button:       UIButton!
    @IBOutlet fileprivate weak var reactionView: ReactionView!
    @IBOutlet fileprivate weak var label:        UILabel!
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    var isVoted: Bool = false {
        didSet { self.reactionView.isVoted = self.isVoted }
    }
    
    var reactionType: ReactionView.ReactionType = ReactionView.ReactionType.wants {
        didSet { self.reactionView.reactionType = self.reactionType }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isVoted = self.reactionView.isVoted
    }
}

extension Reactive where Base: ReactionFooterButtonView {
    func controlEvent(_ controlEvent: UIControlEvents) -> Driver<Void> {
        return self.base.button.rx.controlEvent(controlEvent).asDriver().throttle(self.base.reactionView.animationDuration)
    }
}
