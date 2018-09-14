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
    let items = BehaviorRelay<[Item]>(value: [])
    
    fileprivate lazy var tappedUserList = AnyObserver<ReactionView.ReactionType> { event in
        if case let .next(reactionType) = event {
            self.coordinator.transition(to: .userList(reactionType: reactionType))
        }
    }
    
    fileprivate lazy var selectedItem = AnyObserver<Void> { event in
        self.coordinator.transition(to: .detail)
    }
    
    init(coordinator: ItemDetailCoordinator) {
        
        self.coordinator = coordinator
        
        ApiClient.ItemService.shared.fetchAll()
            .asDriver(onErrorJustReturn: [])
            .drive(self.items)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Output
extension OutputSpace where Definer: ItemDetailViewModel {
    var updateItems: Observable<[ItemDetailSectionModel]> {
        return self.definer.items
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
    
    var tappedUserList: AnyObserver<ReactionView.ReactionType> {
        return self.definer.tappedUserList
    }
    
    var selectedItem: AnyObserver<Void> {
        return self.definer.selectedItem
    }
}

