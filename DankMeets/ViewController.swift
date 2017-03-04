//
//  ViewController.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
	
	let cellId = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "Home"
		navigationController?.navigationBar.translucent = false
		
		setupCollectionView()
	}
	
	func setupCollectionView(){
		if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .Horizontal
		}
		
		collectionView?.backgroundColor = UIColor.whiteColor()
		
		collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
		
		collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
		collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
		
		cell.backgroundColor = UIColor.blueColor()
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(view.frame.width, view.frame.height)
	}
	
	
}

