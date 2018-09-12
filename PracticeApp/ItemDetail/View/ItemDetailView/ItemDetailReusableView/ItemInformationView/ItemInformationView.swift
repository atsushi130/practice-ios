//
//  ItemInformationView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/02.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
final class ItemInformationView: UIView, NibDesignable {
    
    @IBOutlet weak var brandView: ItemInformationBrandView!
    @IBOutlet weak var searchView: ItemInformationTextView!
    @IBOutlet weak var categoryView: ItemInformationTextView!
    @IBOutlet weak var sourceWebView: ItemInformationTextView!

    // MARK: - ItemInformationView Inspectables
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get { return self.layer.borderColor!.ex.uiColor }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    // MARK: - Brand Inspectables
    
    // MARK: - Search Inspectables
    @IBInspectable
    var searchTitle: String? {
        get { return self.searchView.title }
        set { self.searchView.title = newValue }
    }
    
    @IBInspectable
    var iconImage: UIImage? {
        get { return self.searchView.iconImage }
        set { self.searchView.iconImage = newValue }
    }
    
    @IBInspectable
    var searchText: String? {
        get { return self.searchView.text }
        set { self.searchView.text = newValue }
    }
    
    // MARK: - Category Inspectables
    @IBInspectable
    var categoryTitle: String? {
        get { return self.categoryView.title }
        set { self.categoryView.title = newValue }
    }
    
    @IBInspectable
    var categoryImage: UIImage? {
        get { return self.categoryView.iconImage }
        set { self.categoryView.iconImage = newValue }
    }
    
    @IBInspectable
    var categoryText: String? {
        get { return self.categoryView.text }
        set { self.categoryView.text = newValue }
    }
    
    // MARK: - Category Inspectables
    @IBInspectable
    var sourceWebTitle: String? {
        get { return self.sourceWebView.title }
        set { self.sourceWebView.title = newValue }
    }
    
    @IBInspectable
    var sourceWebIconImage: UIImage? {
        get { return self.sourceWebView.iconImage }
        set { self.sourceWebView.iconImage = newValue }
    }
    
    @IBInspectable
    var sourceWebText: String? {
        get { return self.sourceWebView.text }
        set { self.sourceWebView.text = newValue }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}
