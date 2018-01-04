//
//  UserCell.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/04.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class UserCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel:    UILabel!
    @IBOutlet private weak var profileLabel: UILabel!
    @IBOutlet private weak var userIconView: UserIconView!
    @IBOutlet private weak var followButton: FollowButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
