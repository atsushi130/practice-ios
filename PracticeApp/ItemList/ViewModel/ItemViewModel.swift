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
    
    fileprivate let items = BehaviorRelay<[Item]>(value: [])
    
    fileprivate lazy var itemSelected = AnyObserver<Void> { event in
        self.coordinator.transition(to: .detail)
    }
    
    init(coordinator: ItemCoordinator) {
        
        self.coordinator = coordinator
        
        ApiClient.items.latest()
            .asDriverIgonringError()
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
}
