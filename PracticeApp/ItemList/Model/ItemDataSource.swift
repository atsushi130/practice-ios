//
//  ItemDataSource.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxDataSources
import Model

enum ItemSectionModel {
    case normalSection(items: [ItemSectionItem])
}

enum ItemSectionItem {
    case normalItem(item: Model.Item)
}

extension ItemSectionModel: SectionModelType {

    typealias Item = ItemSectionItem
    
    var items: [ItemSectionItem] {
        switch self {
        case let .normalSection(items):
            return items
        }
    }
    
    init(original: ItemSectionModel, items: [ItemSectionItem]) {
        self = original
    }
}
