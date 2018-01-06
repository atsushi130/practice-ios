//
//  NewFolderCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/07.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class NewFolderCell: UICollectionViewCell {

    @IBOutlet private weak var viewConstraintsWidth:  NSLayoutConstraint!
    @IBOutlet private weak var viewConstraintsHeight: NSLayoutConstraint!
    
    var cellWidth: CGFloat = 0.0 {
        didSet {
            let folderHeaderHeight         = 37.0 as CGFloat
            let folderCollectionViewMargin = 2.00 as CGFloat
            self.viewConstraintsWidth.constant  = self.cellWidth
            self.viewConstraintsHeight.constant = self.cellWidth + folderHeaderHeight - folderCollectionViewMargin
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3.0
    }
}
