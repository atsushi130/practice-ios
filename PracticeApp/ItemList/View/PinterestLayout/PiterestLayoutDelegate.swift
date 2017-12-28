//
//  PiterestLayoutDelegate.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
public protocol PinterestLayoutDelegate: class {
    
    // MARK: - Required
    func collectionViewLayout(for section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    // MARK: - Optional
    func collectionView(_ collectionView: UICollectionView, minimumInteritemSpacingFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, minimumLineSpacingFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, sectionInsetFor section: Int) -> UIEdgeInsets?
    func collectionView(_ collectionView: UICollectionView, headerHeightFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, headerInsetFor section: Int) -> UIEdgeInsets?
    func collectionView(_ collectionView: UICollectionView, footerHeightFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, footerInsetFor section: Int) -> UIEdgeInsets?
}

extension PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, minimumInteritemSpacingFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, minimumLineSpacingFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, sectionInsetFor section: Int) -> UIEdgeInsets? { return nil }
    func collectionView(_ collectionView: UICollectionView, headerHeightFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, headerInsetFor section: Int) -> UIEdgeInsets? { return nil }
    func collectionView(_ collectionView: UICollectionView, footerHeightFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, footerInsetFor section: Int) -> UIEdgeInsets? { return nil }
}

