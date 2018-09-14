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
public final class ItemInformationView: UIView, NibDesignable {
    
    @IBOutlet weak var brandView: ItemInformationBrandView!
    @IBOutlet weak var searchView: ItemInformationTextView!
    @IBOutlet weak var categoryView: ItemInformationTextView!
    @IBOutlet weak var sourceWebView: ItemInformationTextView!

    // MARK: - ItemInformationView Inspectables
    @IBInspectable
    public var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    public var borderColor: UIColor {
        get { return self.layer.borderColor!.ex.uiColor }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    // MARK: - Brand Inspectables
    
    // MARK: - Search Inspectables
    @IBInspectable
    public var searchTitle: String? {
        get { return self.searchView.title }
        set { self.searchView.title = newValue }
    }
    
    @IBInspectable
    public var iconImage: UIImage? {
        get { return self.searchView.iconImage }
        set { self.searchView.iconImage = newValue }
    }
    
    @IBInspectable
    public var searchText: String? {
        get { return self.searchView.text }
        set { self.searchView.text = newValue }
    }
    
    // MARK: - Category Inspectables
    @IBInspectable
    public var categoryTitle: String? {
        get { return self.categoryView.title }
        set { self.categoryView.title = newValue }
    }
    
    @IBInspectable
    public var categoryImage: UIImage? {
        get { return self.categoryView.iconImage }
        set { self.categoryView.iconImage = newValue }
    }
    
    @IBInspectable
    public var categoryText: String? {
        get { return self.categoryView.text }
        set { self.categoryView.text = newValue }
    }
    
    // MARK: - Category Inspectables
    @IBInspectable
    public var sourceWebTitle: String? {
        get { return self.sourceWebView.title }
        set { self.sourceWebView.title = newValue }
    }
    
    @IBInspectable
    public var sourceWebIconImage: UIImage? {
        get { return self.sourceWebView.iconImage }
        set { self.sourceWebView.iconImage = newValue }
    }
    
    @IBInspectable
    public var sourceWebText: String? {
        get { return self.sourceWebView.text }
        set { self.sourceWebView.text = newValue }
    }
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}
