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
    
    @IBOutlet fileprivate weak var wants: ReactionFooterButtonView!
    @IBOutlet fileprivate weak var haves: ReactionFooterButtonView!

    private let disposeBag = DisposeBag()
    fileprivate let updateStateEvent = PublishSubject<ReactionState>()
    
    fileprivate var reactionState = ReactionState(wants: false, haves: false) {
        didSet {
            self.wants.isVoted = self.reactionState.wants
            self.haves.isVoted = self.reactionState.haves
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
            .map { ReactionState(wants: self.wants.isVoted, haves: self.haves.isVoted) }
            .map { ReactionViewModel.wants.changeState(to: $0) }
            .drive(self.updateStateEvent)
            .disposed(by: self.disposeBag)
        
        self.haves.rx.controlEvent(.touchUpInside)
            .map { ReactionState(wants: self.wants.isVoted, haves: self.haves.isVoted) }
            .map { ReactionViewModel.haves.changeState(to: $0) }
            .drive(self.updateStateEvent)
            .disposed(by: self.disposeBag)
    }
}

extension Reactive where Base: ReactionFooterView {
    
    var reactionState: Binder<ReactionState> {
        return Binder(self.base) { element, value in
            element.reactionState = value
        }
    }
    
    var updateState: Observable<ReactionState> {
        return self.base.updateStateEvent
            .do(onNext: { reactionState in
                self.base.wants.isVoted = reactionState.wants
                self.base.haves.isVoted = reactionState.haves
            })
    }
}
