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

typealias ReactionState = (wants: Bool, haves: Bool)

@IBDesignable final class ReactionBarsView: UIView {
    
    @IBOutlet fileprivate weak var wants: ReactionBarView!
    @IBOutlet fileprivate weak var haves: ReactionBarView!

    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    private let disposeBag = DisposeBag()
    fileprivate let updateStateEvent = PublishSubject<ReactionState>()
    fileprivate let tappedUserList   = PublishSubject<ReactionView.ReactionType>()
    
    fileprivate var reactionState: ReactionState = ReactionState(wants: false, haves: false) {
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
        
        self.wants.rx.tappedUserList
            .subscribe(self.tappedUserList)
            .disposed(by: self.disposeBag)
        
        self.haves.rx.tappedUserList
            .subscribe(self.tappedUserList)
            .disposed(by: self.disposeBag)
    }
}

extension Reactive where Base: ReactionBarsView {
    
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
    
    var tappedUserList: Observable<ReactionView.ReactionType> {
        return self.base.tappedUserList
    }
}
