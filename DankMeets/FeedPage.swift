//
//  FeedPage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class FeedPage : Page, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	let cellId = "cellId"
	
	lazy var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = UIColor.white
		cv.dataSource = self
		cv.delegate = self
		return cv
	}()
	
	override func setupViews() {
		collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
		
		addSubview(collectionView)
		addConstraintsWithFormat("H:|[v0]|", views: collectionView)
		addConstraintsWithFormat("V:|[v0]|", views: collectionView)
	}
	
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
		
		return cell
	}
	
	
}
