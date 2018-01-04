//
//  LabelResusableView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/04.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class LabelReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var label: UILabel!
    
    var text: String = "" {
        didSet { self.label.text = self.text }
    }
}
