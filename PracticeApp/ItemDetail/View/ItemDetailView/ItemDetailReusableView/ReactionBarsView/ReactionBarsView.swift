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

typealias Reaction = (wants: Bool, haves: Bool)

@IBDesignable final class ReactionBarsView: UIView {
    
    @IBOutlet fileprivate weak var wants: ReactionBarView!
    @IBOutlet fileprivate weak var haves: ReactionBarView!

    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    private let disposeBag = DisposeBag()
    fileprivate let updateStateEvent = PublishSubject<Reaction>()
    fileprivate let tappedUserList   = PublishSubject<ReactionView.ReactionType>()
    
    fileprivate var reaction: Reaction = Reaction(wants: false, haves: false) {
        didSet {
            self.wants.isVoted = reaction.wants
            self.haves.isVoted = reaction.haves
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    private func setup() {
        self.wants.reactionType = .wants
        self.haves.reactionType = .haves
        self.observe()
    }
    
    private func observe() {
        
        self.wants.rx.controlEvent(.touchUpInside)
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                let reaction = ReactionViewModel.wants.changeState(reaction: Reaction(wants: self.wants.isVoted, haves: self.haves.isVoted))
                self.bindState(reaction: reaction)
            })
            .disposed(by: self.disposeBag)
        
        self.haves.rx.controlEvent(.touchUpInside)
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                let reaction = ReactionViewModel.haves.changeState(reaction: Reaction(wants: self.wants.isVoted, haves: self.haves.isVoted))
                self.bindState(reaction: reaction)
            })
            .disposed(by: self.disposeBag)
        
        self.wants.rx.tappedUserList
            .subscribe(self.tappedUserList)
            .disposed(by: self.disposeBag)
        
        self.haves.rx.tappedUserList
            .subscribe(self.tappedUserList)
            .disposed(by: self.disposeBag)
    }
    
    private func bindState(reaction: Reaction) {
        self.wants.isVoted = reaction.wants
        self.haves.isVoted = reaction.haves
        self.updateStateEvent.onNext(reaction)
    }
}

extension Reactive where Base: ReactionBarsView {
    
    var isOn: Binder<Reaction> {
        return Binder(self.base) { element, value in
            element.reaction = value
        }
    }
    
    var updateState: Observable<Reaction> {
        return self.base.updateStateEvent
    }
    
    var tappedUserList: Observable<ReactionView.ReactionType> {
        return self.base.tappedUserList
    }
}
