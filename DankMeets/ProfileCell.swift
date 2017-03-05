//
//  ProfileCell.swift
//  DankMeets
//
//  Created by Terry Chiang on 3/5/17.
//  Copyright © 2017 Cool. All rights reserved.
//

import Foundation
import UIKit

class ProfileCell : FeedCell{
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profItem : ProfileItem? {
        didSet{
            let titleText = (profItem?.fname)! + "'s Profile Page"
            titleLabel.text = titleText
            let friendText = profItem?.friend_count
            friendLabel.text = friendText as! String?
        }
    }
    
    let friendLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        addSubview(titleLabel)
        addSubview(friendLabel)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: titleLabel)
    }
    
}
