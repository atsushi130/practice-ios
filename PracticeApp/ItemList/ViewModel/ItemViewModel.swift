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
    
    private let coordinator: ItemCoordinator
    private let disposeBag = DisposeBag()
    
    let items = BehaviorRelay<[Item]>(value: [])
    
    fileprivate lazy var itemSelected = AnyObserver<Void> { event in
        self.coordinator.transition(to: .detail)
    }
    
    init(coordinator: ItemCoordinator) {
        
        self.coordinator = coordinator
        
        ApiClient.ItemService.shared.fetchAll()
            .map { items in
                return items.map { item in
                    let isOn  = (wants: item.reaction.wants.state, haves: item.reaction.haves.state)
                    let count = (wants: item.reaction.wants.count, haves: item.reaction.haves.count)
                    return Item(id: item.id, name: item.name, subName: item.subName, isOn: isOn, count: count)
                }
            }
            .asDriver(onErrorJustReturn: [])
            .drive(self.items)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Output
extension OutputSpace where Definer: ItemViewModel {
    var updateItems: Observable<[ItemSectionModel]> {
        return self.definer.items
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
    
    var itemSelected: AnyObserver<Void> {
        return self.definer.itemSelected
    }
    
    var item: Binder<(Item, Int)> {
        return Binder(self.definer) { element, value in
            let (item, index) = value
            var items = element.items.value
            items[index] = item
            element.items.accept(items)
        }
    }
}
