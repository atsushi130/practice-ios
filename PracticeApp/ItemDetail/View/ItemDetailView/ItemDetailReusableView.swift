//
//  ItemDetailView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ItemDetailReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var reactionBarsView: ReactionBarsView!
    @IBOutlet private weak var itemNameView: ItemNameView!
    @IBOutlet private weak var itemInformationView: ItemInformationView!
    @IBOutlet private weak var itemLogView: ItemLogView!
    @IBOutlet private weak var itemActionView: ItemActionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
