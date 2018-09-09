//
//  MySumallyViewModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import Connectable

final class MySumallyViewModel: Connectable {}

extension OutputSpace where Definer: MySumallyViewModel {
    var updateMySumallies: Observable<[MySumallySectionModel]> {
        return Observable.just(ItemCollectionCell.CellType.allCases)
            .map { $0.map(MySumallySectionItem.normalItem) }
            .map(MySumallySectionModel.normalSection)
            .map { [$0] }
    }
}
