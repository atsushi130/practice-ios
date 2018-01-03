//
//  ItemDetailView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ItemDetailReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var reactionBarsView: ReactionBarsView!
    @IBOutlet private weak var itemNameView: ItemNameView!
    @IBOutlet private weak var itemInformationView: ItemInformationView!
    @IBOutlet private weak var itemLogView: ItemLogView!
    @IBOutlet private weak var itemActionView: ItemActionView!
    @IBOutlet private weak var reactionFooterView: ReactionFooterView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(itemDetail: ItemDetail) {
        self.itemNameView.bind(name: (main: itemDetail.name, sub: itemDetail.subName))
    }
}
