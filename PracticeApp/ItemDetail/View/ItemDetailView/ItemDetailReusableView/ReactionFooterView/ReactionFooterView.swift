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

final class ReactionFooterView: UIView {
    
    @IBOutlet private weak var wants: ReactionFooterButtonView!
    @IBOutlet private weak var haves: ReactionFooterButtonView!

    private let disposeBag = DisposeBag()
    fileprivate let updateStateEvent = PublishSubject<Reaction>()
    
    fileprivate var reaction = Reaction(wants: false, haves: false) {
        didSet {
            self.wants.isVoted = self.reaction.wants
            self.haves.isVoted = self.reaction.haves
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
    }
    
    private func bindState(reaction: Reaction) {
        self.wants.isVoted = reaction.wants
        self.haves.isVoted = reaction.haves
        self.updateStateEvent.onNext(reaction)
    }
}

extension Reactive where Base: ReactionFooterView {
    
    var isOn: Binder<Reaction> {
        return Binder(self.base) { element, value in
            element.reaction = value
        }
    }
    
    var updateState: Observable<Reaction> {
        return self.base.updateStateEvent
    }
}
