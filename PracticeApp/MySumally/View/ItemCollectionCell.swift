//
//  ItemCollectionCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/06.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ItemCollectionCell: UICollectionViewCell {
    
    @IBOutlet private var iconView:   UIImageView!
    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!

    @IBOutlet private weak var collectionViewConstraintsWidth:  NSLayoutConstraint!
    @IBOutlet private weak var collectionViewConstraintsHeight: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewConstraintsMargin: NSLayoutConstraint!

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.layout = UICollectionViewFlowLayout()
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.ex.register(cellType: ImageCell.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
        didSet {
            self.layout.itemSize     = CGSize(width: 1.0, height: 1.0)
            self.layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.layout.minimumLineSpacing = 0
            self.layout.minimumInteritemSpacing = 0
        }
    }
    
    struct Matrix {
        let x: Int
        let y: Int
    }
    
    var matrix: Matrix = Matrix(x: 1, y: 1) {
        didSet {
            self.updateMatrix()
        }
    }
    
    var collectionViewWidth: CGFloat = 1.0 {
        didSet {
            self.collectionViewConstraintsWidth.constant  = self.collectionViewWidth
            self.updateMatrix()
        }
    }
    
    var collectionViewMargin: CGFloat {
        return self.collectionViewConstraintsMargin.constant
    }
    
    let itemImages: [Int: UIImage] = [0: #imageLiteral(resourceName: "sample"), 1: #imageLiteral(resourceName: "sample1"), 2: #imageLiteral(resourceName: "sample2"), 3: #imageLiteral(resourceName: "sample3"), 4: #imageLiteral(resourceName: "sample4"), 5: #imageLiteral(resourceName: "sample5"), 6: #imageLiteral(resourceName: "sample6"), 7: #imageLiteral(resourceName: "sample7"), 8: #imageLiteral(resourceName: "sample8"), 9: #imageLiteral(resourceName: "sample"), 10: #imageLiteral(resourceName: "sample1")]

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3.0
    }
    
    private func updateMatrix() {
        let width = self.collectionViewConstraintsWidth.constant / CGFloat(self.matrix.x)
        self.collectionViewConstraintsHeight.constant = width * CGFloat(self.matrix.y)
        self.layout.itemSize = CGSize(width: width, height: width)
    }
}

// MARK: - UICollectionViewDelegate
extension ItemCollectionCell: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension ItemCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matrix.x * self.matrix.y
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ex.dequeueReusableCell(with: ImageCell.self, for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.ex.hex(string: "F2F2F2") : UIColor.ex.hex(string: "ECECEC")
        cell.image = self.itemImages[indexPath.row]
        return cell
    }
}
