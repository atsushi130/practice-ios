//
//  ItemDetailDataSource.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/08.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxDataSources
import Model

enum ItemDetailSectionModel {
    case detailSection
    case normalSection(items: [ItemDetailSectionItem], title: String)
    case folderSection(item: ItemDetailSectionItem, title: String)
}

enum ItemDetailSectionItem {
    case normalItem(item: Model.Item)
    case folderItem // FIXME: to ItemDetailSectionModel
}

extension ItemDetailSectionModel: SectionModelType {
    
    typealias Item = ItemDetailSectionItem
    
    var items: [ItemDetailSectionItem] {
        switch self {
        case .detailSection:
            return []
        case let .normalSection(items, _):
            return items
        case let .folderSection(item, _):
            return [item]
        }
    }
    
    init(original: ItemDetailSectionModel, items: [ItemDetailSectionItem]) {
        self = original
    }
}
