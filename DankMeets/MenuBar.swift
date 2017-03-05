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
		cv.backgroundColor = UIColor.red
		cv.dataSource = self
		cv.delegate = self
		return cv
	}()
	
	let cellId = "cellId"
	let imageNames = ["profile", "feed"]
	
	override init(frame: CGRect) {
		super.init(frame : frame)
		
		collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
		
//		let titleLabel = UILabel(frame: CGRectMake(0, 0, frame.width - 32, frame.height))
//		titleLabel.text = "DankMeets"
//		titleLabel.textColor = UIColor.blackColor()
//		titleLabel.font = UIFont.systemFontOfSize(20)
		
		addSubview(collectionView)
		addConstraintsWithFormat("H:|[v0]|", views: collectionView)
		addConstraintsWithFormat("V:|[v0]|", views: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
		
		cell.backgroundColor = UIColor.blue
		
		return cell
	}

	private func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width / 4, height: frame.height)
	}

	func collectionView(_ collectionView: UICollectionView, minimumInteritemSpacingForSectionAtIndex indexPath: IndexPath) -> CGFloat {
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

		addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

}

