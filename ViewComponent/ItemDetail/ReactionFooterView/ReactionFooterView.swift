//
//  ReactionFooterView.swift
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
public final class ReactionFooterView: UIView, NibDesignable {
    
    @IBOutlet fileprivate weak var wants: ReactionFooterButtonView!
    @IBOutlet fileprivate weak var haves: ReactionFooterButtonView!

    private let disposeBag = DisposeBag()
    fileprivate let updateStateEvent = PublishSubject<Reactions>()
    
    fileprivate var reactions = Reactions.default {
        didSet {
            self.wants.isVoted = self.reactions.wants.state
            self.haves.isVoted = self.reactions.haves.state
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
    
    private func setup() {
        self.wants.reactionType = .wants
        self.haves.reactionType = .haves
        self.observe()
    }
    
    private func observe() {
        
        self.wants.rx.controlEvent(.touchUpInside)
            .do(onNext: { self.reactions.switch(of: .wants) })
            .map { self.reactions }
            .drive(self.updateStateEvent)
            .disposed(by: self.disposeBag)
        
        self.haves.rx.controlEvent(.touchUpInside)
            .do(onNext: { self.reactions.switch(of: .haves) })
            .map { self.reactions }
            .drive(self.updateStateEvent)
            .disposed(by: self.disposeBag)
    }
}

public extension Reactive where Base: ReactionFooterView {
    
    public var reactions: Binder<Reactions> {
        return Binder(self.base) { element, value in
            element.reactions = value
        }
    }
    
    public var updateReactions: Observable<Reactions> {
        return self.base.updateStateEvent
            .do(onNext: { reactions in
                self.base.wants.isVoted = reactions.wants.state
                self.base.haves.isVoted = reactions.haves.state
            })
    }
}
