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
import Model
import ViewComponent

final class ItemCell: UICollectionViewCell {

    @IBOutlet private weak var imageView:     UIImageView!
    @IBOutlet private weak var mainNameLabel: UILabel!
    @IBOutlet private weak var subNameLabel:  UILabel!
    @IBOutlet fileprivate weak var wants: ItemButton!
    @IBOutlet fileprivate weak var haves: ItemButton!
    @IBOutlet private weak var imageConstraintsWidth:  NSLayoutConstraint!
    @IBOutlet private weak var imageConstraintsHeight: NSLayoutConstraint!
    
    private var item: Item? = nil
    let disposeBag = DisposeBag()
    private let updateReactions = PublishSubject<Reactions>()

    var cellWidth: CGFloat = 0.0 {
        didSet { self.imageConstraintsWidth.constant = self.cellWidth }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    private func setup() {
        self.wants.reactionType = .wants
        self.haves.reactionType = .haves
        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        self.observe()
    }
    
    private func observe() {
        
        self.wants.rx.controlEvent(.touchUpInside)
            .do (onNext: { self.item?.reaction.switch(of: .wants) })
            .map { self.item!.reaction }
            .drive(self.updateReactions)
            .disposed(by: self.disposeBag)
        
        self.haves.rx.controlEvent(.touchUpInside)
            .do (onNext: { self.item?.reaction.switch(of: .haves) })
            .map { self.item!.reaction }
            .drive(self.updateReactions)
            .disposed(by: self.disposeBag)
        
        self.updateReactions
            .do(onNext: { reactions in
                self.wants.isVoted = reactions.wants.state
                self.haves.isVoted = reactions.haves.state
            })
            .subscribe()
            .disposed(by: self.disposeBag)
    }
    
    func bind(item: Item) {
        self.item = item
        self.mainNameLabel.text = item.name
        self.subNameLabel.text  = item.subName
        self.wants.isVoted = item.reaction.wants.state
        self.haves.isVoted = item.reaction.haves.state
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
