//
//  ItemViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx
import CoordinatorKit

extension ItemViewController: RoutableViewController {
    typealias ViewControllerConfigurator = ItemConfigurator
    typealias Dependency = Void
}

final class ItemViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            self.collectionView.ex.register(cellType: ItemCell.self)
        }
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        // self sizing by autolayout
        layout.estimatedItemSize = CGSize(width: 172, height: 263)
        layout.sectionInset      = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing      = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    var viewModel: ItemViewModel!
    
    private lazy var dataSource = {
        return RxCollectionViewSectionedReloadDataSource<ItemSectionModel>(configureCell: { (dataSource, _, indexPath, sectionItem) in
            switch sectionItem {
            case let .normalItem(item):
                let cell = self.collectionView.ex.dequeueReusableCell(with: ItemCell.self, for: indexPath)
                cell.bind(item: item)
                let inset  = self.layout.sectionInset
                let margin = self.layout.minimumInteritemSpacing + inset.left + inset.right
                cell.cellWidth = (self.collectionView.frame.size.width - margin).ex.half.ex.floor
                return cell
            }
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.out.updateItems
            .asDriverWithPracticeErrorAlert(on: self)
            .drive(self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.rx.disposeBag)
        
        self.collectionView.rx.modelSelected(ItemSectionItem.self).asObservable()
            .map { $0.item }
            .subscribe(self.viewModel.in.itemSelected)
            .disposed(by: self.rx.disposeBag)
    }
}
