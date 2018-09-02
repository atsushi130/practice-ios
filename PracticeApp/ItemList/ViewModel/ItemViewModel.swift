//
//  ItemViewModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import RxSwift
import RxCocoa

struct ItemViewModel {
    
    fileprivate var items: [Item] = []
    fileprivate let updateItems = Variable<[Item]>([])
    
    var count: Int {
        return self.items.count
    }
    
    subscript(_ index: Int) -> Item {
        get { return self.items[index] }
        set { self.items[index] = newValue }
    }
    
    mutating func fetch() {
        self.items = [
            Item(name: "Main Item1", subName: "Sub Name1", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item2", subName: "Sub Name2", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item3", subName: "Sub Name3", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item4", subName: "Sub Name4", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item5", subName: "Sub Name5", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item6", subName: "Sub Name6", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item7", subName: "Sub Name7", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item8", subName: "Sub Name8", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item9", subName: "Sub Name9", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item10", subName: "Sub Name10", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item11", subName: "Sub Name11", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item12", subName: "Sub Name12", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item13", subName: "Sub Name13", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item14", subName: "Sub Name14", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item15", subName: "Sub Name15", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item16", subName: "Sub Name16", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item17", subName: "Sub Name17", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item18", subName: "Sub Name18", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item19", subName: "Sub Name19", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item20", subName: "Sub Name20", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item21", subName: "Sub Name21", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item22", subName: "Sub Name22", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item23", subName: "Sub Name23", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item24", subName: "Sub Name24", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item25", subName: "Sub Name25", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item26", subName: "Sub Name26", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item27", subName: "Sub Name27", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item28", subName: "Sub Name28", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item29", subName: "Sub Name29", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0)),
            Item(name: "Main Item30", subName: "Sub Name30", isOn: (wants: true, haves: false), count: (wants: 0, haves: 0))
        ]
        
        self.updateItems.value = self.items
    }
}

extension ItemViewModel: ReactiveCompatible {}
extension Reactive where Base == ItemViewModel {
    var updateItems: Driver<[Item]> {
        return self.base.updateItems.asDriver()
    }
}
