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
    
    fileprivate var items: Variable<[Item]> = Variable([])
    
    var count: Int {
        return self.items.value.count
    }
    
    subscript(_ index: Int) -> Item {
        get { return self.items.value[index] }
        set { self.items.value[index] = newValue }
        
    }
    
    func fetch() {
        let item = Item(name: "Main Item", subName: "Sub Name", isOn: (wants: true, haves: false))        
        self.items.value = Array(repeating: item, count: 30)
    }
}

extension ItemViewModel: ReactiveCompatible {}
extension Reactive where Base == ItemViewModel {
    var didChange: Driver<[Item]> {
        return self.base.items.asDriver()
    }
}
