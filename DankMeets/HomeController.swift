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
	
	fileprivate func setupMenuBar(){
		view.addSubview(menuBar)
		view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
		view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
	}
	
	func setupCollectionView(){
		if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .horizontal
			flowLayout.minimumLineSpacing = 0
		}
		
		collectionView?.backgroundColor = UIColor.white
		
		collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
		
		collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
		collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
		
		collectionView?.isPagingEnabled = true
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
		
		let colors: [UIColor] = [.blue, .white, .red]
		
		cell.backgroundColor = colors[indexPath.item]
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: view.frame.height)
	}
	
	
}

extension UIView {
	
	func addConstraintsWithFormat(_ format: String, views: UIView...) {
		var viewsDictionary = [String: UIView]()
		for (index, view) in views.enumerated() {
			let key = "v\(index)"
			view.translatesAutoresizingMaskIntoConstraints = false
			viewsDictionary[key] = view
		}
		
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
	}
	
}

