//
//  ImageCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/05.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.image = #imageLiteral(resourceName: "sample")
    }
}
