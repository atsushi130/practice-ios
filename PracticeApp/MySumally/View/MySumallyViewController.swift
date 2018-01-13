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
            self.collectionView.contentInset         = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            self.collectionView.ex.register(cellType: ItemCollectionCell.self)
            self.collectionView.ex.register(cellType: NewFolderCell.self)
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
    
    private enum CellType {
        case wants
        case haves
        case adds
        case folder
        case addFolder
        
        func toItemCollectionCellType() -> ItemCollectionCell.CellType? {
            switch self {
            case .wants:     return .wants
            case .haves:     return .haves
            case .adds:      return .adds
            case .folder:    return .folder
            case .addFolder: return nil
            }
        }
    }
    
    private let cellTypes: [CellType] = [.wants, .haves, .adds, .folder, .addFolder]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - UICollectionViewDelegate
// numberOfSections is default implemented
extension MySumallyViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension MySumallyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let margin   = self.layout.sectionInset.left + self.layout.sectionInset.right
        let cellType = self.cellTypes[indexPath.row]

        switch cellType {
        case .folder:
            let cell = collectionView.ex.dequeueReusableCell(with: ItemCollectionCell.self, for: indexPath)
            cell.collectionViewWidth = (self.collectionView.frame.size.width - self.layout.minimumInteritemSpacing - margin).ex.half.ex.floor - (cell.collectionViewMargin * 2)
            cell.matrix   = ItemCollectionCell.Matrix(x: 3, y: 3)
            cell.cellType = .folder
            return cell
            
        case .wants, .haves, .adds:
            let cell = collectionView.ex.dequeueReusableCell(with: ItemCollectionCell.self, for: indexPath)
            cell.collectionViewWidth = self.collectionView.frame.size.width - margin - (cell.collectionViewMargin * 2)
            cell.matrix = ItemCollectionCell.Matrix(x: 5, y: 3)
            if let itemCollectionCellType = cellType.toItemCollectionCellType() { cell.cellType = itemCollectionCellType }
            return cell
            
        case .addFolder:
            let cell = collectionView.ex.dequeueReusableCell(with: NewFolderCell.self, for: indexPath)
            cell.cellWidth = (self.collectionView.frame.size.width - self.layout.minimumInteritemSpacing - margin).ex.half.ex.floor
            return cell
        }
    }
}
