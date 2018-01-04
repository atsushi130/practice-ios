//
//  FunButton.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftExtensions

@IBDesignable final class FollowButton: UIButton, NibDesignable {
    
    @IBInspectable
    var buttonTitle: String? {
        get { return self.titleLabel?.text }
        set { self.titleLabel?.text = newValue }
    }
    
    private(set) var isFollowed: Bool = false {
        didSet { self.changeView() }
    }
    
    var title: (followed: String, notFollowing: String) = (followed: "フォロー中", notFollowing: "フォローする")

    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get { return self.layer.borderColor!.ex.uiColor }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.observe()
    }
    
    private func observe() {
        self.rx.controlEvent(.touchUpInside).asDriver().drive(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.isFollowed = !self.isFollowed
        }).disposed(by: self.disposeBag)
    }
    
    private func changeView() {
        switch self.isFollowed {
        case true:
            self.buttonTitle     = self.title.followed
            self.backgroundColor = UIColor.theme
            self.setTitleColor(UIColor.white, for: .normal)
        case false:
            self.buttonTitle     = self.title.notFollowing
            self.backgroundColor = UIColor.clear
            self.setTitleColor(UIColor.theme, for: .normal)
        }
    }
}
