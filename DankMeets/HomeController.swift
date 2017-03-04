//
//  ViewController.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	let cellId = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
		setupMenuBar()
	}
	
	let menuBar : MenuBar = {
		let mb = MenuBar()
		return mb
	}()
	
	private func setupMenuBar(){
		view.addSubview(menuBar)
//		view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
//		view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
	}
	
	func setupCollectionView(){
		if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .Horizontal
			flowLayout.minimumLineSpacing = 0
		}
		
		collectionView?.backgroundColor = UIColor.whiteColor()
		
		collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
		
//		collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//		collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
		
		collectionView?.pagingEnabled = true
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
		
		let colors: [UIColor] = [.blueColor(), .whiteColor(), .redColor()]
		
		cell.backgroundColor = colors[indexPath.item]
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(view.frame.width, view.frame.height)
	}
	
	
}

extension UIView {
	
	func addConstraints(withFormat format: String, views: UIView...) {
		var viewsDictionary = [String: UIView]()
		for (index, view) in views.enumerate() {
			let key = "v\(index)"
			view.translatesAutoresizingMaskIntoConstraints = false
			viewsDictionary[key] = view
		}
		
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
	}
	
}

