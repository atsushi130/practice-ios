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
import Model
import SwiftExtensions

@IBDesignable
final class ReactionFooterButtonView: UIView, NibDesignable {
    
    @IBOutlet fileprivate weak var button:       UIButton!
    @IBOutlet fileprivate weak var reactionView: ReactionView!
    @IBOutlet fileprivate weak var label:        UILabel!
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var markImage: UIImage? {
        get { return self.reactionView.markImage }
        set { self.reactionView.markImage = newValue }
    }
    
    var isVoted: Bool = false {
        didSet { self.reactionView.isVoted = self.isVoted }
    }
    
    var reactionStyle: Reactions.Style = Reactions.Style.wants {
        didSet { self.reactionView.reactionStyle = self.reactionStyle }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isVoted = self.reactionView.isVoted
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}

extension Reactive where Base: ReactionFooterButtonView {
    func controlEvent(_ controlEvent: UIControlEvents) -> Driver<Void> {
        return self.base.button.rx.controlEvent(controlEvent).asDriver().throttle(self.base.reactionView.animationDuration)
    }
}
