//
//  ItemDetailFolderCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ItemDetailFolderCell: UICollectionViewCell {
    
    @IBOutlet weak var constraintsWidth: NSLayoutConstraint!
    
    @IBOutlet private weak var folderNameLabel: UILabel!
    @IBOutlet private weak var userIconView:    UserIconView!
    @IBOutlet private weak var userNameLabel:   UILabel!
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.layout = UICollectionViewFlowLayout()
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.ex.register(cellType: ImageCell.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
        didSet {
            let width = self.collectionView.frame.size.width / 3
            self.layout.itemSize = CGSize(width: width, height: width)
            self.layout.minimumLineSpacing      = 0
            self.layout.minimumInteritemSpacing = 0
        }
    }
    
    var cellWidth: CGFloat = 0.0 {
        didSet { self.constraintsWidth.constant = self.cellWidth }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3.0
    }
}

// MARK: - UICollectionViewDelegate
extension ItemDetailFolderCell: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension ItemDetailFolderCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.ex.dequeueReusableCell(with: ImageCell.self, for: indexPath)
    }
}
