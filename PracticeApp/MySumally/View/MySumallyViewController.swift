//
//  MySumallyViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/06.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import NSObject_Rx
import CoordinatorKit

extension MySumallyViewController: RoutableViewController {
    typealias ViewControllerConfigurator = MySumallyConfigurator
    typealias Dependency = Void
}

final class MySumallyViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.contentInset         = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            self.collectionView.ex.register(cellType: ItemCollectionCell.self)
            self.collectionView.ex.register(cellType: NewFolderCell.self)
        }
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize  = CGSize(width: 1.0, height: 1.0)
        layout.sectionInset       = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing      = 15.0
        return layout
    }()
    
    private let viewModel = MySumallyViewModel()
    
    private lazy var dataSource = {
        return RxCollectionViewSectionedReloadDataSource<MySumallySectionModel>(configureCell: { (dataSource, _, indexPath, sectionItem) in
            switch sectionItem {
            case let .normalItem(cellType):
                let margin = self.layout.sectionInset.left + self.layout.sectionInset.right
                switch cellType {
                case .folder:
                    let cell = self.collectionView.ex.dequeueReusableCell(with: ItemCollectionCell.self, for: indexPath)
                    cell.collectionViewWidth = (self.collectionView.frame.size.width - self.layout.minimumInteritemSpacing - margin).ex.half.ex.floor - (cell.collectionViewMargin * 2)
                    cell.matrix   = ItemCollectionCell.Matrix(x: 3, y: 3)
                    cell.cellType = .folder
                    return cell
                    
                case .wants, .haves, .adds:
                    let cell = self.collectionView.ex.dequeueReusableCell(with: ItemCollectionCell.self, for: indexPath)
                    cell.collectionViewWidth = self.collectionView.frame.size.width - margin - (cell.collectionViewMargin * 2)
                    cell.matrix = ItemCollectionCell.Matrix(x: 5, y: 3)
                    cell.cellType = cellType
                    return cell
                    
                case .addFolder:
                    let cell = self.collectionView.ex.dequeueReusableCell(with: NewFolderCell.self, for: indexPath)
                    cell.cellWidth = (self.collectionView.frame.size.width - self.layout.minimumInteritemSpacing - margin).ex.half.ex.floor
                    return cell
                }
            }
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.out.updateMySumallies
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.rx.disposeBag)
    }
}
