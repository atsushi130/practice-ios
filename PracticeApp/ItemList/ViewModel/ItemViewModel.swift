//
//  ItemViewModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import RxSwift
import RxCocoa
import Connectable
import NSObject_Rx
import Model
import Data

final class ItemViewModel: Connectable {
    
    let coordinator: ItemCoordinator
    private let disposeBag = DisposeBag()
    fileprivate let updateItems: Observable<[Item]>
    
    fileprivate lazy var itemSelected = AnyObserver<Item> { event in
        if case .next(let item) = event {
            self.coordinator.transition(to: .detail(itemId: item.id))
        }
    }
    
    init(coordinator: ItemCoordinator) {
        self.coordinator = coordinator
        self.updateItems = PracticeApi.items.latest()
    }
}

// MARK: - Output
extension OutputSpace where Definer: ItemViewModel {
    var updateItems: Observable<[ItemSectionModel]> {
        return self.definer.updateItems
            .map { items in
                return items.map { item in ItemSectionItem.normalItem(item: item) }
            }
            .map { items -> [ItemSectionModel] in
                return [ItemSectionModel.normalSection(items: items)]
            }
            .share(replay: 1, scope: .forever)
    }
}

// MARK: - Input
extension InputSpace where Definer: ItemViewModel {
    var itemSelected: AnyObserver<Item> {
        return self.definer.itemSelected
    }
}
