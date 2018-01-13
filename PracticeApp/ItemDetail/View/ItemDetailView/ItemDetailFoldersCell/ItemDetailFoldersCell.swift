//
//  ItemDetailFoldersCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ItemDetailFoldersCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var constraintsWidth: NSLayoutConstraint!
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.layout = UICollectionViewFlowLayout()
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.showsHorizontalScrollIndicator = false
            self.collectionView.ex.register(cellType: ItemDetailFolderCell.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
        didSet {
            self.layout.itemSize        = CGSize(width: 150, height: 205)
            self.layout.sectionInset    = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            self.layout.scrollDirection = .horizontal
        }
    }
    
    var cellWidth: CGFloat = 0.0 {
        didSet {
            self.constraintsWidth.constant = self.cellWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - UICollectionViewDelegate
// numberOfSections is default implemented
extension ItemDetailFoldersCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension ItemDetailFoldersCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ex.dequeueReusableCell(with: ItemDetailFolderCell.self, for: indexPath)
        cell.cellWidth = 150.0
        return cell
    }
}
