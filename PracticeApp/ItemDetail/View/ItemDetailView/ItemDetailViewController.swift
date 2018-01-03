//
//  ItemDetailViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/04.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ItemDetailViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.layout = UICollectionViewFlowLayout()
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.ex.register(cellType: ItemCell.self)
            self.collectionView.ex.register(reusableViewType: ItemDetailReusableView.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout() {
        didSet {
            // self sizing by autolayout
            self.layout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
            self.layout.headerReferenceSize = CGSize(width: self.collectionView.frame.size.width, height: 946)
            self.layout.sectionInset      = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            self.layout.minimumLineSpacing      = 10
            self.layout.minimumInteritemSpacing = 10
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private var itemViewModel = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemViewModel.rx.didChange.drive(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        }).disposed(by: self.disposeBag)
        
        self.itemViewModel.fetch()
    }
}

// MARK: - UICollectionViewDelegate
extension ItemDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension ItemDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.ex.dequeueReusableCell(with: ItemCell.self, for: indexPath)
        
        cell.bind(item: self.itemViewModel[indexPath.row])
        cell.tapped = { isOn in self.itemViewModel[indexPath.row].isOn = isOn }
        
        let inset  = self.layout.sectionInset
        let margin = self.layout.minimumInteritemSpacing + inset.left + inset.right
        cell.cellWidth = (self.collectionView.frame.size.width - margin).ex.half.ex.floor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.ex.dequeueReusableView(with: ItemDetailReusableView.self, for: indexPath)
    }
}
