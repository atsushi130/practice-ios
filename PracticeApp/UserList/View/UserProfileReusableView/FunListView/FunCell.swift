//
//  FunCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/07.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class FunCell: UICollectionViewCell {
    
    @IBOutlet private weak var brandLabel: UILabel!
    
    var text: String = "" {
        didSet {
            self.brandLabel.text = self.text
            self.setNeedsLayout()
            self.brandLabel.sizeToFit()
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.brandLabel.preferredMaxLayoutWidth = 345.0
        self.brandLabel.layer.cornerRadius      = self.brandLabel.frame.size.height.ex.half
    }
}
