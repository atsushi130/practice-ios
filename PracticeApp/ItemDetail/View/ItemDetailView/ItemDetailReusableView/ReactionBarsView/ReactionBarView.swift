//
//  ReactionBarView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftExtensions

@IBDesignable
final class ReactionBarView: UIView, NibDesignable {

    @IBOutlet fileprivate weak var button:         UIButton!
    @IBOutlet fileprivate weak var reactionView:   ReactionView!
    @IBOutlet private weak var countLabel:         UILabel!
    @IBOutlet fileprivate weak var userListButton: UIButton!
 
    var isVoted: Bool = false {
        didSet { self.reactionView.isVoted = self.isVoted }
    }
    
    @IBInspectable
    var markImage: UIImage? {
        get { return self.reactionView.markImage }
        set { self.reactionView.markImage = newValue }
    }
    
    var reactionType: ReactionView.ReactionType = ReactionView.ReactionType.wants {
        didSet { self.reactionView.reactionType = self.reactionType }
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

extension Reactive where Base: ReactionBarView {
    
    func controlEvent(_ controlEvent: UIControlEvents) -> Driver<Void> {
        return self.base.button.rx.controlEvent(controlEvent).asDriver().throttle(self.base.reactionView.animationDuration)
    }
    
    var tappedUserList: Observable<ReactionView.ReactionType> {
        return self.base.userListButton.rx.controlEvent(.touchUpInside)
            .map { self.base.reactionType }
    }
}
