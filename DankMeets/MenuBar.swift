//
//  MenuBar.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class MenuBar : UIView {
	
	let collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = UIColor.redColor()
		return cv
	}()
	
	override init(frame: CGRect) {
		super.init(frame : frame)
		
//		let titleLabel = UILabel(frame: CGRectMake(0, 0, frame.width - 32, frame.height))
//		titleLabel.text = "DankMeets"
//		titleLabel.textColor = UIColor.blackColor()
//		titleLabel.font = UIFont.systemFontOfSize(20)
		
		addSubview(collectionView)
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	
	
}