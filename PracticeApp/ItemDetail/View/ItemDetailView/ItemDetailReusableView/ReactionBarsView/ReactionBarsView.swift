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

@IBDesignable final class ReactionBarsView: UIView {
    
    @IBOutlet fileprivate weak var wants: ReactionBarView!
    @IBOutlet fileprivate weak var haves: ReactionBarView!

    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    private let disposeBag = DisposeBag()
    typealias IsOn = (wants: Bool, haves: Bool)
    fileprivate let updateStateEvent = PublishSubject<IsOn>()
    
    fileprivate var isOn: IsOn = IsOn(wants: false, haves: false) {
        didSet {
            self.wants.isOn = isOn.wants
            self.haves.isOn = isOn.haves
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    private func setup() {
        self.wants.buttonType = .wants
        self.haves.buttonType = .haves
        self.observe()
    }
    
    private func observe() {
        
        self.wants.rx.controlEvent(.touchUpInside).drive(onNext: { [weak self] in
            guard let `self` = self else { return }
            let isOn = ReactionViewModel.wants.changeState(isOn: IsOn(wants: self.wants.isOn, haves: self.haves.isOn))
            self.bindState(isOn: isOn)
        }).disposed(by: self.disposeBag)
        
        self.haves.rx.controlEvent(.touchUpInside).drive(onNext: { [weak self] in
            guard let `self` = self else { return }
            let isOn = ReactionViewModel.haves.changeState(isOn: IsOn(wants: self.wants.isOn, haves: self.haves.isOn))
            self.bindState(isOn: isOn)
        }).disposed(by: self.disposeBag)
    }
    
    private func bindState(isOn: IsOn) {
        self.wants.isOn = isOn.wants
        self.haves.isOn = isOn.haves
        self.updateStateEvent.onNext(isOn)
    }
}

extension Reactive where Base: ReactionBarsView {
    
    var isOn: Binder<ReactionFooterView.IsOn> {
        return Binder(self.base) { element, value in
            element.isOn = value
        }
    }
    
    var didStateUpdate: Driver<ReactionBarsView.IsOn> {
        return self.base.updateStateEvent.asDriver(onErrorDriveWith: Driver.empty())
    }
}
