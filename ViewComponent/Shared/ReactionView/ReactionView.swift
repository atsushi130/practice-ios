//
//  ReactionView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
public final class ReactionView: UIView, NibDesignable {
    
    @IBOutlet private weak var animationView: UIView!
    @IBOutlet private weak var markView: UIImageView!
    
    fileprivate struct Const {
        typealias OnOff = (on: CGFloat, off: CGFloat)
        static let animationDuration     = 0.45
        static let springDamping: OnOff  = (on: 0.4, off: 1.0)
        static let springVelocity: OnOff = (on: 0.0, off: 1.0)
        static let options: UIViewAnimationOptions = .curveEaseIn
    }
    
    public var animationDuration: Double { return Const.animationDuration }
    
    @IBInspectable
    public var markImage: UIImage? {
        get { return self.markView.image }
        set { self.markView.image = newValue }
    }
    
    public enum ReactionType: String {
        case wants = "wants"
        case haves = "haves"
        public var title: String {
            switch self {
            case .wants: return "wantしている人"
            case .haves: return "haveしている人"
            }
        }
    }
    
    public var reactionType: ReactionType = .wants {
        didSet {
            self.changeMark()
        }
    }
    
    public var isVoted = false {
        didSet {
            self.changeAnimation()
        }
    }
    
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
        self.animationView.backgroundColor    = UIColor.theme
        self.animationView.layer.cornerRadius = self.frame.size.width.ex.half
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }

    private func changeMark() {
        self.markView.image = UIImage(named: self.reactionType.rawValue + "_mark")
    }
    
    private func changeAnimation() {
        
        switch self.isVoted {
        case true:
            UIView.animate(withDuration: Const.animationDuration,
                           delay: 0,
                           usingSpringWithDamping: Const.springDamping.on,
                           initialSpringVelocity:  Const.springVelocity.on,
                           options: Const.options,
                           animations: {
                            self.animationView.transform = CGAffineTransform.identity
            }) { _ in }
            
        case false:
            UIView.animate(withDuration: Const.animationDuration,
                           delay: 0,
                           usingSpringWithDamping: Const.springDamping.off,
                           initialSpringVelocity:  Const.springVelocity.off,
                           options: Const.options,
                           animations: {
                            self.animationView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }) { _ in }
        }
    }
}
