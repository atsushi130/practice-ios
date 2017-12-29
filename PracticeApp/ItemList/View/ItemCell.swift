//
//  ItemCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ItemCell: UICollectionViewCell {

    @IBOutlet private weak var imageView:     UIImageView!
    @IBOutlet private weak var mainNameLabel: UILabel!
    @IBOutlet private weak var subNameLabel:  UILabel!
    @IBOutlet fileprivate weak var wants:     ItemButton!
    @IBOutlet fileprivate weak var haves:     ItemButton!
    @IBOutlet private weak var imageConstraintsWidth:  NSLayoutConstraint!
    @IBOutlet private weak var imageConstraintsHeight: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    
    var cellWidth: CGFloat = 0.0 {
        didSet { self.imageConstraintsWidth.constant = self.cellWidth }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    private func setup() {
        
        self.wants.buttonType = .wants
        self.haves.buttonType = .haves
        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        self.observe()
    }
    
    private func observe() {
        
        self.wants.rx.controlEvent(.touchUpInside).drive(onNext: { [unowned self] _ in
            switch self.haves.isOn {
            case true:
                self.haves.isOn = false
                self.wants.isOn = true
            case false:
                self.wants.isOn = !self.wants.isOn
            }
            self.tap()
        }).disposed(by: self.disposeBag)
        
        self.haves.rx.controlEvent(.touchUpInside).drive(onNext: { [unowned self] _ in
            switch self.wants.isOn {
            case true:
                self.wants.isOn = false
                self.haves.isOn = true
            case false:
                self.haves.isOn = !self.haves.isOn
            }
            self.tap()
        }).disposed(by: self.disposeBag)
    }
    
    func bind(item: Item) {
        self.mainNameLabel.text = item.name
        self.subNameLabel.text  = item.subName
        self.wants.isOn = item.isOn.wants
        self.haves.isOn = item.isOn.haves
    }
    
    var tapped: ((wants: Bool, haves: Bool)) -> Void = { isOn in }
    private func tap() {
        self.tapped((wants: self.wants.isOn, haves: self.haves.isOn))
    }
    
    private func imageSizeFit(imageSize: CGSize) {
        let fitScale = imageSize.width / self.cellWidth
        self.imageConstraintsHeight.constant = imageSize.height * fitScale
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        // able to refarence attributes of cell has sized by auto layout.
        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
}
