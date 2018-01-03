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

final class ReactionBarView: UIView {

    @IBOutlet fileprivate weak var button:       UIButton!
    @IBOutlet fileprivate weak var reactionView: ReactionView!
    @IBOutlet private weak var countLabel:       UILabel!
    
    var isOn: Bool = false {
        didSet { self.reactionView.isOn = self.isOn }
    }
    
    var buttonType: ReactionView.ButtonType = ReactionView.ButtonType.wants {
        didSet { self.reactionView.buttonType = self.buttonType }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isOn = self.reactionView.isOn
    }
}

extension Reactive where Base: ReactionBarView {
    func controlEvent(_ controlEvent: UIControlEvents) -> Driver<Void> {
        return self.base.button.rx.controlEvent(controlEvent).asDriver().throttle(self.base.reactionView.animationDuration)
    }
}
