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
            self.collectionView.ex.register(reusableViewType: LabelReusableView.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout() {
        didSet {
            // self sizing by autolayout
            self.layout.estimatedItemSize   = CGSize(width: 1.0, height: 1.0)
            self.layout.headerReferenceSize = CGSize(width: 1.0, height: 1.0)
            self.layout.sectionInset        = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
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
    
    deinit {
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
        print("item detail view controller deinit")
    }
}

// MARK: - UICollectionViewDelegate
extension ItemDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

// MARK: - UICollectionViewDataSource
extension ItemDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        case 1: return self.itemViewModel.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // このアイテムが含まれるフォルダ
        // 関連アイテム
        
        let cell = collectionView.ex.dequeueReusableCell(with: ItemCell.self, for: indexPath)
        
        cell.bind(item: self.itemViewModel[indexPath.row])
        cell.rx.didReactionUpdate.subscribe(onNext: { [weak self] item in
            self?.itemViewModel[indexPath.row] = item
        }).disposed(by: cell.disposeBag)
        
        let inset  = self.layout.sectionInset
        let margin = self.layout.minimumInteritemSpacing + inset.left + inset.right
        cell.cellWidth = (self.collectionView.frame.size.width - margin).ex.half.ex.floor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        print(self.view.ex.safeAreaInsets.bottom)
        switch indexPath.section {
        case 0:
            let header = collectionView.ex.dequeueReusableView(with: ItemDetailReusableView.self, for: indexPath)
            
            let updateConstraints = { [weak self] in
                guard let `self` = self else { return }
                let offsetY    = self.collectionView.contentOffset.y
                let hideHeight = 34.0 as CGFloat
                let threshold  = header.frame.size.height - self.view.frame.size.height + self.view.ex.safeAreaInsets.bottom
                let offset     = offsetY <= threshold ? threshold - offsetY - hideHeight : -hideHeight
                header.reactionFooterView.snp.updateConstraints { make in
                    make.bottom.equalTo(header.snp.bottom).offset(-offset)
                }
            }
            
            // initial
            updateConstraints()
            
            self.collectionView.rx.didScroll.asDriver().drive(onNext: {
                updateConstraints()
            }).disposed(by: header.disposeBag)
            
            return header
            
        default:
            let header = collectionView.ex.dequeueReusableView(with: LabelReusableView.self, for: indexPath)
            header.text = "関連アイテム"
            return header
        }
    }
}

extension ItemDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:  return CGSize(width: collectionView.frame.size.width, height: 946)
        default: return CGSize(width: collectionView.frame.size.width, height: 30)
        }
    }
}

