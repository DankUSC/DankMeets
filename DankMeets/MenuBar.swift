//
//  MenuBar.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class MenuBar : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	lazy var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = UIColor.redColor()
		cv.dataSource = self
		cv.delegate = self
		return cv
	}()
	
	let cellId = "cellId"
	let imageNames = ["profile", "feed"]
	
	override init(frame: CGRect) {
		super.init(frame : frame)
		
		collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: cellId)
		
//		let titleLabel = UILabel(frame: CGRectMake(0, 0, frame.width - 32, frame.height))
//		titleLabel.text = "DankMeets"
//		titleLabel.textColor = UIColor.blackColor()
//		titleLabel.font = UIFont.systemFontOfSize(20)
		
		addSubview(collectionView)
		addConstraintsWithFormat("H:|[v0]|", views: collectionView)
		addConstraintsWithFormat("V:|[v0]|", views: collectionView)
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
		
		cell.backgroundColor = UIColor.blueColor()
		
		return cell
	}

	func collectionView(collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(frame.width / 4, frame.height)
	}

	func collectionView(collectionView: UICollectionView, minimumInteritemSpacingForSectionAtIndex indexPath: NSIndexPath) -> CGFloat {
		return 0
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
}

class MenuCell : UICollectionViewCell {

	let imageView : UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "")
		return iv
	}()
	
	override init(frame: CGRect) {
		super.init(frame : frame)

	}

	func setupViews(){
		addSubview(imageView)
		addConstraintsWithFormat("H:[v0(28)]", views: imageView)
		addConstraintsWithFormat("V:[v0(28)]", views: imageView)

		addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

}

