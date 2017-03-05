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
	
	var meetItem: MeetItem? {
		didSet {
			setupSelfieImage()
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "HH:mm"
			dateFormatter.locale = Locale.init(identifier: "en_US")
			var text = dateFormatter.string(from: (meetItem?.time)!) + ": "
			text += (meetItem?.username1!)! + " met "
			text += (meetItem?.username2)! + " at "
			text += (meetItem?.event)! + "!"
			messageLabel.text = text
		}
	}
	
	func setupSelfieImage(){
		if let selfieImageURL = meetItem?.selfieURL {
			
			let url = URL(string: selfieImageURL)
			URLSession.shared.dataTask(with: url! as URL, completionHandler: {
				(data, response, error) in
				
				if error != nil {
					print(error!)
					return
				}
				
				DispatchQueue.main.async(execute: {
					self.selfieImageView.image = UIImage(data: data!)
				})
				
			}).resume()
		}
	}
	
	let selfieImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = UIColor.white
		return imageView
	}()
	
	let messageLabel : UILabel = {
		let label = UILabel()
		label.backgroundColor = UIColor.white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let separatorView : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.black
		return view
	}()
	
	override func setupViews() {
		addSubview(selfieImageView)
		addSubview(messageLabel)
		addSubview(separatorView)
		
		addConstraintsWithFormat("H:|-16-[v0]-16-|", views: messageLabel)
		addConstraintsWithFormat("H:|-16-[v0]-16-|", views: selfieImageView)
		addConstraintsWithFormat("V:|-16-[v0]-[v1(24)]-16-[v2(2)]|", views: selfieImageView, messageLabel, separatorView)
		addConstraintsWithFormat("H:|[v0]|", views: separatorView)
	}
	
}

class EventCell : FeedCell {

	override func setupViews() {
		
	}
	
}


class NearbyCell : FeedCell {
	
	var nearbyItem: NearbyItem? {
		didSet {
			titleLabel.text = nearbyItem?.user
			locationLabel.text = String((nearbyItem?.lat)!) + ", " + String((nearbyItem?.lon)!)
		}
	}
	
	let titleLabel : UILabel = {
		let label = UILabel()
		label.backgroundColor = UIColor.white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let locationLabel : UILabel = {
		let label = UILabel()
		label.backgroundColor = UIColor.white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let separatorView : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.black
		return view
	}()
	
	override func setupViews(){
		addSubview(separatorView)
		addSubview(titleLabel)
		addSubview(locationLabel)
		
		addConstraintsWithFormat("H:|-20-[v0]-[v1]-20-|", views: titleLabel, locationLabel)
		addConstraintsWithFormat("V:|[v0(1)]-14-[v1]", views: separatorView, titleLabel)
		addConstraintsWithFormat("H:|-16-[v0]-16-|", views: separatorView)
		addConstraint(NSLayoutConstraint(item: locationLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: locationLabel, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
	}
	
}

class ProfileCell : FeedCell {
	
	var profileItem : ProfileItem? {
		didSet{
			let titleText = (profileItem?.fname)! + "'s Profile Page"
			titleLabel.text = titleText
			let friendText = profileItem?.friend_count
			friendLabel.text = friendText as! String?
		}
	}
	
	let friendLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let titleLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override func setupViews() {
		addSubview(titleLabel)
		addSubview(friendLabel)
		addConstraintsWithFormat("H:|-16-[v0]-16-|", views: titleLabel)
	}
	
}
