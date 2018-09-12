//
//  ReactionView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Model
import SwiftExtensions

@IBDesignable
final class ReactionBarsView: UIView, NibDesignable {
    
    @IBOutlet fileprivate weak var wants: ReactionBarView!
    @IBOutlet fileprivate weak var haves: ReactionBarView!

    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var wantsMarkImage: UIImage? {
        get { return self.wants.markImage }
        set { self.wants.markImage = newValue }
    }
    
    @IBInspectable
    var havesMarkImage: UIImage? {
        get { return self.haves.markImage }
        set { self.haves.markImage = newValue }
    }
    
    private let disposeBag = DisposeBag()
    fileprivate let updateStateEvent = PublishSubject<Reactions>()
    fileprivate let tappedUserList   = PublishSubject<ReactionView.ReactionType>()
    
    fileprivate var reactions: Reactions = Reactions.default {
        didSet {
            self.wants.isVoted = self.reactions.wants.state
            self.haves.isVoted = self.reactions.haves.state
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
        
        self.wants.rx.tappedUserList
            .subscribe(self.tappedUserList)
            .disposed(by: self.disposeBag)
        
        self.haves.rx.tappedUserList
            .subscribe(self.tappedUserList)
            .disposed(by: self.disposeBag)
    }
}

extension Reactive where Base: ReactionBarsView {
    
    var reactions: Binder<Reactions> {
        return Binder(self.base) { element, value in
            element.reactions = value
        }
    }
    
    var updateReactions: Observable<Reactions> {
        return self.base.updateStateEvent
            .do(onNext: { reactions in
                self.base.wants.isVoted = reactions.wants.state
                self.base.haves.isVoted = reactions.haves.state
            })
    }
    
    var tappedUserList: Observable<ReactionView.ReactionType> {
        return self.base.tappedUserList
    }
}
