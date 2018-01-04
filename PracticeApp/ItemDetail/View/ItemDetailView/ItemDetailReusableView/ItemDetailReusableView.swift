//
//  ItemDetailView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift

final class ItemDetailReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var reactionBarsView: ReactionBarsView!
    @IBOutlet private weak var itemNameView: ItemNameView!
    @IBOutlet private weak var itemInformationView: ItemInformationView!
    @IBOutlet private weak var itemLogView: ItemLogView!
    @IBOutlet private weak var itemActionView: ItemActionView!
    @IBOutlet weak var reactionFooterView: ReactionFooterView!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.observe()
    }
    
    private func observe() {
        self.reactionBarsView.rx.didStateUpdate.drive(self.reactionFooterView.rx.isOn).disposed(by: self.disposeBag)
        self.reactionFooterView.rx.didStateUpdate.drive(self.reactionBarsView.rx.isOn).disposed(by: self.disposeBag)
    }
    
    func bind(itemDetail: ItemDetail) {
        self.itemNameView.bind(name: (main: itemDetail.name, sub: itemDetail.subName))
    }
    
    deinit {
        print("deinit item detail reusable view")
    }
}
