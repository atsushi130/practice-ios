//
//  PinterestLayout.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/28.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class PinterestLayout: UICollectionViewLayout {
    
    var minimumLineSpacing: CGFloat = Const.minimumLineSpacing {
        didSet { self.invalidateLayoutIfChanged(oldValue, minimumLineSpacing) }
    }
    
    var minimumInteritemSpacing: CGFloat = Const.minimumInteritemSpacing {
        didSet { self.invalidateLayoutIfChanged(oldValue, minimumInteritemSpacing) }
    }
    
    var sectionInset: UIEdgeInsets = Const.sectionInset {
        didSet { self.invalidateLayoutIfChanged(oldValue, sectionInset) }
    }
    
    var headerHeight: CGFloat = Const.headerHeight {
        didSet { self.invalidateLayoutIfChanged(oldValue, headerHeight) }
    }
    
    var headerInset: UIEdgeInsets = Const.headerInset {
        didSet { self.invalidateLayoutIfChanged(oldValue, headerInset) }
    }
    
    var footerHeight: CGFloat = Const.footerHeight {
        didSet { self.invalidateLayoutIfChanged(oldValue, footerHeight) }
    }
    
    var footerInset: UIEdgeInsets = Const.footerInset {
        didSet { self.invalidateLayoutIfChanged(oldValue, footerInset) }
    }
    
    private typealias AttributesDictonary = [Int: UICollectionViewLayoutAttributes]
    private typealias Attributes          = [UICollectionViewLayoutAttributes]
    private lazy var attribute: (headers: AttributesDictonary, footers: AttributesDictonary, items: Attributes, sectionItems: [Attributes]) = ([:], [:], [], [])
    
    private lazy var columnHeights: [[CGFloat]]           = []
    private lazy var cachedItemSizes: [IndexPath: CGSize] = [:]
    
    weak var delegate: PinterestLayoutDelegate?
    
    public override func prepare() {
        
        super.prepare()
        self.cleanup()
        
        guard let collectionView = self.collectionView else { return }
        guard let delegate = self.delegate else { return }
        
        let numberOfSections = collectionView.numberOfSections
        if numberOfSections == 0 { return }
        
        (0..<numberOfSections).forEach { section in
            let columnCount = delegate.collectionViewLayout(for: section)
            columnHeights.append(Array(repeating: 0.0, count: columnCount))
        }
        
        var position: CGFloat = 0.0
        (0..<numberOfSections).forEach { section in
            layoutHeader(position: &position, collectionView: collectionView, delegate: delegate, section: section)
            layoutItems(position: position, collectionView: collectionView, delegate: delegate, section: section)
            layoutFooter(position: &position, collectionView: collectionView, delegate: delegate, section: section)
        }
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.section >= self.attribute.sectionItems.count { return nil }
        if indexPath.item >= self.attribute.sectionItems[indexPath.section].count { return nil }
        return self.attribute.sectionItems[indexPath.section][indexPath.item]
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attribute.items.filter { rect.intersects($0.frame) }
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds.width != (self.collectionView?.bounds ?? .zero).width
    }
    
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
                                         withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        return self.cachedItemSizes[originalAttributes.indexPath] != preferredAttributes.size
    }
    
    override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
                                      withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        
        guard let collectionView = self.collectionView else { return context }
        
        let oldContentSize = self.collectionViewContentSize
        cachedItemSizes[originalAttributes.indexPath] = preferredAttributes.size
        
        let newContentSize = self.collectionViewContentSize
        context.contentSizeAdjustment = CGSize(width: 0, height: newContentSize.height - oldContentSize.height)
        
        let indexPaths: [IndexPath] = (originalAttributes.indexPath.item..<collectionView.numberOfItems(inSection: originalAttributes.indexPath.section))
            .map { [originalAttributes.indexPath.section, $0] }
        context.invalidateItems(at: indexPaths)
        
        return context
    }
    
    private func cleanup() {
        self.attribute.headers.removeAll()
        self.attribute.footers.removeAll()
        self.attribute.items.removeAll()
        self.attribute.sectionItems.removeAll()
        self.columnHeights.removeAll()
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView, collectionView.numberOfSections > 0  else { return .zero }
        var contentSize    = collectionView.bounds.size
        contentSize.height = self.columnHeights.last?.first ?? 0.0
        return contentSize
    }
    
    private func layoutHeader(position: inout CGFloat, collectionView: UICollectionView,  delegate: PinterestLayoutDelegate, section: Int) {
        
        let columnCount  = delegate.collectionViewLayout(for: section)
        let headerHeight = self.headerHeight(for: section)
        let headerInset  = self.headerInset(for: section)
        
        position += headerInset.top
        
        if headerHeight > 0 {
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: [section, 0])
            attributes.frame = CGRect(
                x: headerInset.left,
                y: position,
                width: collectionView.bounds.width - (headerInset.left + headerInset.right),
                height: headerHeight
            )
            self.attribute.headers[section] = attributes
            self.attribute.items.append(attributes)
            
            position = attributes.frame.maxY + headerInset.bottom
        }
        
        position += sectionInset.top
        self.columnHeights[section] = Array(repeating: position, count: columnCount)
    }
    
    private func layoutItems(position: CGFloat, collectionView: UICollectionView, delegate: PinterestLayoutDelegate, section: Int) {
        
        let minimumInteritemSpacing = self.minimumInteritemSpacing(for: section)
        let minimumLineSpacing      = self.minimumInteritemSpacing(for: section)
        
        let columnCount = delegate.collectionViewLayout(for: section)
        let itemCount   = collectionView.numberOfItems(inSection: section)
        let width       = collectionView.bounds.width - (sectionInset.left + sectionInset.right)
        let itemWidth   = floor((width - CGFloat(columnCount - 1) * minimumLineSpacing) / CGFloat(columnCount))
        let paddingLeft = itemWidth + minimumLineSpacing
        
        let itemAttributes: Attributes = (0..<itemCount).map { index in
            let indexPath: IndexPath = [section, index]
            let columnIndex = index % columnCount
            
            
            let itemSize = delegate.collectionView(collectionView, sizeForItemAt: indexPath)
            self.cachedItemSizes[indexPath] = itemSize
            
            let itemHeight: CGFloat = itemSize.height > 0 && itemSize.width > 0 ? floor(itemSize.height * itemWidth / itemSize.width) : 0.0
            
            let offsetY    = self.columnHeights[section][columnIndex]
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(
                x: sectionInset.left + paddingLeft * CGFloat(columnIndex),
                y: offsetY,
                width: itemWidth,
                height: itemHeight
            )
            
            self.columnHeights[section][columnIndex] = attributes.frame.maxY + minimumInteritemSpacing
            return attributes
        }
        
        self.attribute.items.append(contentsOf: itemAttributes)
        self.attribute.sectionItems.append(itemAttributes)
    }
    
    private func layoutFooter(position: inout CGFloat, collectionView: UICollectionView, delegate: PinterestLayoutDelegate, section: Int) {
        
        let sectionInset            = self.sectionInset(for: section)
        let minimumInteritemSpacing = self.minimumInteritemSpacing(for: section)
        let columnCount             = delegate.collectionViewLayout(for: section)
        let longestColumnIndex      = self.columnHeights[section].enumerated().sorted { $0.element > $1.element }.first?.offset ?? 0
        
        if self.columnHeights[section].count > 0 {
            position = columnHeights[section][longestColumnIndex] - minimumInteritemSpacing + sectionInset.bottom
        } else {
            position = 0.0
        }
        
        let footerHeight = self.footerHeight(for: section)
        let footerInset  = self.footerInset(for: section)
        position += footerInset.top
        
        if footerHeight > 0.0 {
            let attributes   = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: [section, 0])
            attributes.frame = CGRect(x: footerInset.left, y: position, width: collectionView.bounds.width - (footerInset.left + footerInset.right), height: footerHeight)
            self.attribute.footers[section] = attributes
            self.attribute.items.append(attributes)
            position = attributes.frame.maxY + footerInset.bottom
        }
        
        self.columnHeights[section] = Array(repeating: position, count: columnCount)
    }
    
    private func invalidateLayoutIfChanged<T: Equatable>(_ old: T, _ new: T) {
        if old != new { self.invalidateLayout() }
    }
    
    private func minimumInteritemSpacing(for section: Int) -> CGFloat {
        return self.collectionView.flatMap { delegate?.collectionView($0, minimumInteritemSpacingFor: section) } ?? self.minimumInteritemSpacing
    }
    
    private func minimumLineSpacing(for section: Int) -> CGFloat {
        return self.collectionView.flatMap { delegate?.collectionView($0, minimumLineSpacingFor: section) } ?? self.minimumLineSpacing
    }
    
    private func sectionInset(for section: Int) -> UIEdgeInsets {
        return self.collectionView.flatMap { delegate?.collectionView($0, sectionInsetFor: section) } ?? self.sectionInset
    }
    
    private func headerHeight(for section: Int) -> CGFloat {
        return self.collectionView.flatMap { delegate?.collectionView($0, headerHeightFor: section) } ?? self.headerHeight
    }
    
    private func headerInset(for section: Int) -> UIEdgeInsets {
        return self.collectionView.flatMap { delegate?.collectionView($0, headerInsetFor: section) } ?? self.headerInset
    }
    
    private func footerHeight(for section: Int) -> CGFloat {
        return self.collectionView.flatMap { delegate?.collectionView($0, footerHeightFor: section) } ?? self.footerHeight
    }
    
    private func footerInset(for section: Int) -> UIEdgeInsets {
        return self.collectionView.flatMap { delegate?.collectionView($0, footerInsetFor: section) } ?? self.footerInset
    }
}
