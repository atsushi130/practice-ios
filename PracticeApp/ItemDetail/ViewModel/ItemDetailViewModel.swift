//
//  ItemDetailViewModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/08.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Connectable
import Model
import Data
import ViewComponent

final class ItemDetailViewModel: Connectable {
    
    private let coordinator: ItemDetailCoordinator
    private let disposeBag = DisposeBag()
    fileprivate let updateItems: Observable<[Item]>
    
    fileprivate lazy var tappedUserList = AnyObserver<Reactions.Style> { event in
        if case let .next(reactionStyle) = event {
            self.coordinator.transition(to: .userList(reactionStyle: reactionStyle))
        }
    }
    
    fileprivate lazy var itemSelected = AnyObserver<Item> { event in
        if case .next(let item) = event {
            self.coordinator.transition(to: .detail(itemId: item.id))
        }
    }
    
    init(coordinator: ItemDetailCoordinator) {
        self.coordinator = coordinator
        self.updateItems = PracticeApi.items.latest()
    }
}

// MARK: - Output
extension OutputSpace where Definer: ItemDetailViewModel {
    var updateItems: Observable<[ItemDetailSectionModel]> {
        return self.definer.updateItems
            .map { items in
                return items.map { item in ItemDetailSectionItem.normalItem(item: item) }
            }
            .map { items -> [ItemDetailSectionModel] in
                return [
                    .detailSection,
                    .folderSection(item: .folderItem, title: "このアイテムが含まれるフォルダ"),
                    .normalSection(items: items, title: "関連アイテム")
                ]
            }
            .share(replay: 1, scope: .forever)
    }
}

// MARK: - Input
extension InputSpace where Definer: ItemDetailViewModel {
    
    var tappedUserList: AnyObserver<Reactions.Style> {
        return self.definer.tappedUserList
    }
    
    var itemSelected: AnyObserver<Item> {
        return self.definer.itemSelected
    }
}
