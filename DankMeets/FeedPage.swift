//
//  FeedPage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class FeedPage : Page, UICollectionViewDataSource, UICollectionViewDelegate {
	
	let meetCellId = "meetCellId"
	let eventCellId = "eventCellId"
	
	lazy var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = UIColor.white
		cv.dataSource = self
		cv.delegate = self
		return cv
	}()
	
	override func setupViews() {
		collectionView.register(MeetCell.self, forCellWithReuseIdentifier: meetCellId)
		collectionView.register(EventCell.self, forCellWithReuseIdentifier: eventCellId)
		
		addSubview(collectionView)
		addConstraintsWithFormat("H:|[v0]|", views: collectionView)
		addConstraintsWithFormat("V:|[v0]|", views: collectionView)
	}
	
	var feedItems: [FeedItem] = {
		var meeting = MeetItem()
		meeting.time = NSDate()
		meeting.username1 = "ldkge"
		meeting.username2 = "okdmrz"
		meeting.selfie = "https://i1.wp.com/slyoyster.com/wp-content/uploads/2014/04/Ortiz-and-Obama-Selfie-2.jpg"
		
		var event = EventItem()
		event.time = NSDate()
		event.username = "okdmrz"
		event.event = "The Oscars"
		
		return [meeting, event]
	}()
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return feedItems.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellId, for: indexPath)
		
		return cell
	}
	
	
}
