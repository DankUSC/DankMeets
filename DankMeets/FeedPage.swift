//
//  FeedPage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class FeedPage : Page, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
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
	
	var feedItems: [FeedItem] = {
		var meeting = MeetItem()
		meeting.time = Date()
		meeting.event = "The Oscars"
		meeting.username1 = "ldkge"
		meeting.username2 = "okdmrz"
		meeting.selfieURL = "https://i1.wp.com/slyoyster.com/wp-content/uploads/2014/04/Ortiz-and-Obama-Selfie-2.jpg"
		
//		var event = EventItem()
//		event.time = Date()
//		event.username = "okdmrz"
//		event.event = "The Oscars"
		
		return [meeting]
//		return []
	}()
	
	override func setupViews() {
		super.setupViews()
		
		if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.minimumLineSpacing = 0
		}
		collectionView.register(MeetCell.self, forCellWithReuseIdentifier: meetCellId)
		collectionView.register(EventCell.self, forCellWithReuseIdentifier: eventCellId)
		
		addSubview(collectionView)
		addConstraintsWithFormat("H:|[v0]|", views: collectionView)
		addConstraintsWithFormat("V:|[v0]|", views: collectionView)
		
        //sending http request to server to obtain data
        let urlString = URL(string: "https://dank-meets.appspot.com/friends/1")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                else{
                    if let usableData = data{
                        do{
                            let json = try JSONSerialization.jsonObject(with: usableData, options: [])
							let dateFormatter = DateFormatter()
							dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            for anItem in json as! [Dictionary<String, Any>] {
								let meetItem = MeetItem()
								let timeStr = anItem["timestamp"] as? String
								meetItem.time = dateFormatter.date(from: timeStr!)
								meetItem.event = anItem["event"] as? String
								meetItem.username1 = anItem["user1"] as? String
								meetItem.username2 = anItem["user2"] as? String
								meetItem.selfieURL = anItem["selfie"] as? String
								self.feedItems.append(meetItem)
                            }
							
							DispatchQueue.main.async(execute: {
								self.collectionView.reloadData()
							})
							
                        } catch{
                            print("JSON error")
                        }
                    }
                }
            }
            task.resume()
        }
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return feedItems.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: meetCellId, for: indexPath) as! MeetCell
		
		cell.meetItem = feedItems[indexPath.item] as? MeetItem
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width, height: 400)
	}
	
	
}
