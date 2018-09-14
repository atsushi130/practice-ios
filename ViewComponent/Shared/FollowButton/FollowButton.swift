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

@IBDesignable
public final class FollowButton: UIView, NibDesignable {
    
    @IBOutlet private weak var button: UIButton!
    
    @IBInspectable
    public var buttonTitle: String? {
        get { return self.button.currentTitle }
        set { self.button.setTitle(newValue, for: .normal) }
    }
    
    private(set) var isFollowed: Bool = false {
        didSet { self.changeView() }
    }
    
    public var title: (followed: String, notFollowing: String) = (followed: "フォロー中", notFollowing: "フォローする")

    @IBInspectable
    public var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    public var borderColor: UIColor {
        get { return self.layer.borderColor!.ex.uiColor }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    private let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.observe()
    }
    
    private func observe() {
        self.button.rx.controlEvent(.touchUpInside).asDriver().drive(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.isFollowed = !self.isFollowed
        }).disposed(by: self.disposeBag)
    }
    
    private func changeView() {
        switch self.isFollowed {
        case true:
            self.backgroundColor = UIColor.theme
            self.buttonTitle = self.title.followed
            self.button.setTitleColor(UIColor.white, for: .normal)
        case false:
            self.backgroundColor = UIColor.clear
            self.buttonTitle = self.title.notFollowing
            self.button.setTitleColor(UIColor.theme, for: .normal)
        }
    }
}
