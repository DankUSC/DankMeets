//
//  FeedCell.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class FeedCell : UICollectionViewCell {
	
	override init(frame : CGRect) {
		super.init(frame : frame)
		setupViews()
	}
	
	func setupViews(){
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class MeetCell : FeedCell {
	
	
	
}

class EventCell : FeedCell {

	
	
}
