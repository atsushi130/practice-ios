//
//  MySumallyViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/06.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class MySumallyViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.layout = UICollectionViewFlowLayout()
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.ex.register(cellType: ItemCollectionCell.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
        didSet {
            self.layout.estimatedItemSize  = CGSize(width: 1.0, height: 1.0)
            self.layout.sectionInset       = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            self.layout.minimumInteritemSpacing = 10.0
            self.layout.minimumLineSpacing      = 15.0
        }
    }
    
    private let cellTypes: [ItemCollectionCell.CellType] = [.wants, .haves, .adds, .folder, .folder]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Atsushi"
    }
}

// MARK: - UICollectionViewDelegate
extension MySumallyViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension MySumallyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.ex.dequeueReusableCell(with: ItemCollectionCell.self, for: indexPath)
        
        let margin   = self.layout.sectionInset.left + self.layout.sectionInset.right
        let cellType = self.cellTypes[indexPath.row]
        
        switch cellType {
        case .folder:
            cell.collectionViewWidth = (self.collectionView.frame.size.width - self.layout.minimumInteritemSpacing - margin).ex.half.ex.floor - (cell.collectionViewMargin * 2)
            cell.matrix = ItemCollectionCell.Matrix(x: 3, y: 3)
            
        default:
            cell.collectionViewWidth = self.collectionView.frame.size.width - margin - (cell.collectionViewMargin * 2)
            cell.matrix = ItemCollectionCell.Matrix(x: 5, y: 3)
        }
        
        cell.cellType = self.cellTypes[indexPath.row]
        
        return cell
    }
}
