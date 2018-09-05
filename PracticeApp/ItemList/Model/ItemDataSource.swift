//
//  ItemDataSource.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxDataSources

enum ItemSectionModel {
    case detailSection
    case normalSection(items: [ItemSectionItem])
    case folderSection(item: ItemSectionItem) // FIXME: to ItemDetailSectionModel
}

enum ItemSectionItem {
    case normalItem(item: Item)
    case folderItem // FIXME: to ItemDetailSectionModel
}

extension ItemSectionModel: SectionModelType {

    typealias Item = ItemSectionItem
    
    var items: [ItemSectionItem] {
        switch self {
        case .detailSection:
            return []
        case let .normalSection(items):
            return items
        case let .folderSection(item):
            return [item]
        }
    }
    
    init(original: ItemSectionModel, items: [ItemSectionItem]) {
        self = original
    }
}
