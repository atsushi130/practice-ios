//
//  MySumallyDataSource.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxDataSources

enum MySumallySectionModel {
    case normalSection(items: [MySumallySectionItem])
}

enum MySumallySectionItem {
    case normalItem(cellType: ItemCollectionCell.CellType)
}

extension MySumallySectionModel: SectionModelType {
    
    typealias Item = MySumallySectionItem
    
    var items: [MySumallySectionItem] {
        switch self {
        case let .normalSection(items):
            return items
        }
    }
    
    init(original: MySumallySectionModel, items: [MySumallySectionItem]) {
        self = original
    }
}
