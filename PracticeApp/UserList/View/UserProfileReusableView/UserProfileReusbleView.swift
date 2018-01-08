//
//  UserProfileReusbleView.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/07.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class UserProfileReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var userIconView:   UserIconView!
    @IBOutlet private weak var userNameLabel:  UILabel!
    @IBOutlet private weak var profileButton:  UIButton!
    @IBOutlet private weak var funListView:    FunListView!
    @IBOutlet private weak var followButton:   UIButton!
    @IBOutlet private weak var followerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
