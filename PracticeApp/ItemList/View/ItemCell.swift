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
    @IBOutlet fileprivate weak var wants: ItemButton!
    @IBOutlet fileprivate weak var haves: ItemButton!
    @IBOutlet private weak var imageConstraintsWidth:  NSLayoutConstraint!
    @IBOutlet private weak var imageConstraintsHeight: NSLayoutConstraint!
    
    private var item: Item? = nil
    let disposeBag = DisposeBag()
    private typealias IsOn = (wants: Bool, haves: Bool)
    fileprivate let itemUpdateEvent = PublishSubject<Item>()
    
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
            .map { [weak self] _ -> ReactionViewModel.IsOn in
                guard let `self` = self else { return ReactionViewModel.IsOn(wants: true, haves: true) }
                return ReactionViewModel.wants.changeState(isOn: IsOn(wants: self.wants.isOn, haves: self.haves.isOn))
            }
            .drive(onNext: { [weak self] isOn in
                self?.bindState(isOn: isOn)
            })
            .disposed(by: self.disposeBag)
        
        self.haves.rx.controlEvent(.touchUpInside)
            .map { [weak self] _ -> ReactionViewModel.IsOn in
                guard let `self` = self else { return ReactionViewModel.IsOn(wants: false, haves: false) }
                return ReactionViewModel.haves.changeState(isOn: IsOn(wants: self.wants.isOn, haves: self.haves.isOn))
            }
            .drive(onNext: { [weak self] isOn in
                self?.bindState(isOn: isOn)
            })
            .disposed(by: self.disposeBag)
    }
    
    func bind(item: Item) {
        self.item = item
        self.mainNameLabel.text = item.name
        self.subNameLabel.text  = item.subName
        self.wants.isOn = item.isOn.wants
        self.haves.isOn = item.isOn.haves
    }
    
    private func bindState(isOn: IsOn) {
        self.item?.isOn = isOn
        self.wants.isOn = isOn.wants
        self.haves.isOn = isOn.haves
        guard let item = self.item else { return }
        self.itemUpdateEvent.onNext(item)
    }
    
    private func imageSizeFit(imageSize: CGSize) {
        let fitScale = imageSize.width / self.cellWidth
        self.imageConstraintsHeight.constant = imageSize.height * fitScale
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        // able to refarence attributes of cell has sized by auto layout.
        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
    
    deinit {
        print("deinit item cell")
    }
}

extension Reactive where Base: ItemCell {
    var updateReaction: Observable<Item> {
        return self.base.itemUpdateEvent
    }
}
