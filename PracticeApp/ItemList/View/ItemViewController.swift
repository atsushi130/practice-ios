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

final class ItemViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.layout = UICollectionViewFlowLayout()
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            self.collectionView.ex.register(cellType: ItemCell.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
        didSet {
            // self sizing by autolayout
            self.layout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
            self.layout.sectionInset      = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            self.layout.minimumLineSpacing      = 10
            self.layout.minimumInteritemSpacing = 10
        }
    }
    
    private let disposeBag    = DisposeBag()
    private var itemViewModel = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemViewModel.out.updateItems
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        self.itemViewModel.fetch()
    }
}

// MARK: - UICollectionViewDelegate
// numberOfSections is default implemented
extension ItemViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension ItemViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.ex.dequeueReusableCell(with: ItemCell.self, for: indexPath)
        
        cell.bind(item: self.itemViewModel[indexPath.row])
        cell.rx.updateReaction
            .subscribe(onNext: { [weak self] item in
                self?.itemViewModel[indexPath.row] = item
            })
            .disposed(by: cell.disposeBag)
        
        let inset  = self.layout.sectionInset
        let margin = self.layout.minimumInteritemSpacing + inset.left + inset.right
        cell.cellWidth = (self.collectionView.frame.size.width - margin).ex.half.ex.floor

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: ItemDetailViewController.ex.className, bundle: nil)
        let itemDetailViewController = storyboard.instantiateInitialViewController() as! ItemDetailViewController
        self.navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}

