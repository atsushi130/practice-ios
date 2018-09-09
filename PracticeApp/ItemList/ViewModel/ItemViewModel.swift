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

final class ItemViewModel: Connectable {
    
    private let coordinator: ItemCoordinator
    private let disposeBag = DisposeBag()
    
    let items = BehaviorRelay<[Item]>(value: [])
    
    fileprivate lazy var itemSelected = AnyObserver<Void> { event in
        self.coordinator.transition(to: .detail)
    }
    
    init(coordinator: ItemCoordinator) {
        
        self.coordinator = coordinator
        
        let items = [
            Item(id: "1", name: "Main Item1", subName: "Sub Name1", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "2", name: "Main Item2", subName: "Sub Name2", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "3", name: "Main Item3", subName: "Sub Name3", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "54", name: "Main Item4", subName: "Sub Name4", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "6", name: "Main Item5", subName: "Sub Name5", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "7", name: "Main Item6", subName: "Sub Name6", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "8", name: "Main Item7", subName: "Sub Name7", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "9", name: "Main Item8", subName: "Sub Name8", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "10", name: "Main Item9", subName: "Sub Name9", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "11", name: "Main Item10", subName: "Sub Name10", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "12", name: "Main Item11", subName: "Sub Name11", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "13", name: "Main Item12", subName: "Sub Name12", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "14", name: "Main Item13", subName: "Sub Name13", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "15", name: "Main Item14", subName: "Sub Name14", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "16", name: "Main Item15", subName: "Sub Name15", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "17", name: "Main Item16", subName: "Sub Name16", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "18", name: "Main Item17", subName: "Sub Name17", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "19", name: "Main Item18", subName: "Sub Name18", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "20", name: "Main Item19", subName: "Sub Name19", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "21", name: "Main Item20", subName: "Sub Name20", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "22", name: "Main Item21", subName: "Sub Name21", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "23", name: "Main Item22", subName: "Sub Name22", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "24", name: "Main Item23", subName: "Sub Name23", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "25", name: "Main Item24", subName: "Sub Name24", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "26", name: "Main Item25", subName: "Sub Name25", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "27", name: "Main Item26", subName: "Sub Name26", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "28", name: "Main Item27", subName: "Sub Name27", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "29", name: "Main Item28", subName: "Sub Name28", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "30", name: "Main Item29", subName: "Sub Name29", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(id: "31", name: "Main Item30", subName: "Sub Name30", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0))
        ]
        
        self.items.accept(items)
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
