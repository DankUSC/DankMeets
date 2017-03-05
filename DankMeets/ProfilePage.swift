//
//  ProfilePage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class ProfilePage : Page {
	
	let profileItem = ProfileItem()
	
	let profilePictureImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = UIColor.white
		imageView.layer.borderWidth = 5
		imageView.layer.masksToBounds = false
		imageView.layer.borderColor = UIColor.black.cgColor
		imageView.clipsToBounds = true
		return imageView
	}()
	
	let nameLabel : UILabel = {
		let label = UILabel()
		label.textColor = UIColor.black
		label.textAlignment = NSTextAlignment.center
		label.font = UIFont.systemFont(ofSize: 36)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let usernameLabel : UILabel = {
		let label = UILabel()
		label.textColor = UIColor.darkGray
		label.textAlignment = NSTextAlignment.center
		label.font = UIFont.systemFont(ofSize: 28)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let friendCountLabel : UILabel = {
		let label = UILabel()
		label.textColor = UIColor.darkGray
		label.textAlignment = NSTextAlignment.center
		label.font = UIFont.systemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
    
    override func setupViews() {
        super.setupViews()
		addSubview(profilePictureImageView)
		addSubview(nameLabel)
		addSubview(usernameLabel)
		addSubview(friendCountLabel)
		
		addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: profilePictureImageView, attribute: .bottom, multiplier: 1, constant: 40))
		addConstraint(NSLayoutConstraint(item: usernameLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 10))
		addConstraint(NSLayoutConstraint(item: friendCountLabel, attribute: .top, relatedBy: .equal, toItem: usernameLabel, attribute: .bottom, multiplier: 1, constant: 10))
		
		addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: profilePictureImageView, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: usernameLabel, attribute: .centerX, relatedBy: .equal, toItem: profilePictureImageView, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: friendCountLabel, attribute: .centerX, relatedBy: .equal, toItem: profilePictureImageView, attribute: .centerX, multiplier: 1, constant: 0))
		
		createJSONTask()
	}
	
	func setupProfilePicture(){
		
		profilePictureImageView.frame = CGRect(x:70, y:50, width: frame.width-140, height: frame.width-140)
		profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
		
		if let profile_picture = profileItem.profile_picture {
			
			let url = URL(string: profile_picture)
			URLSession.shared.dataTask(with: url! as URL, completionHandler: {
				(data, response, error) in
				
				if error != nil {
					print(error!)
					return
				}
				
				DispatchQueue.main.async(execute: {
					self.profilePictureImageView.image = UIImage(data: data!)
				})
				
			}).resume()
		}
	}
	
	func populateViews(){
		setupProfilePicture()
		nameLabel.text = (profileItem.first_name)! + " " + (profileItem.last_name)!
		usernameLabel.text = "@" + (profileItem.username)!
		let friendCount = (profileItem.friend_count)!
		if (friendCount == 1){
			friendCountLabel.text = "1 Friend"
		} else {
			friendCountLabel.text = String(friendCount) + " Friends"
		}
	}
	
	func createJSONTask(){
		//sending request to get profile information
		let urlString = URL(string: "https://dank-meets.appspot.com/profile/1")
		if let url = urlString {
			let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
				if error != nil {
					print(error!)
				}
				else{
					if let usableData = data{
						do{
							let json = try JSONSerialization.jsonObject(with: usableData, options: [])
							print(json)
							for anItem in json as! [Dictionary<String, Any>] {
								self.profileItem.username = anItem["username"] as? String
								self.profileItem.friend_count = anItem["friend_count"] as? Int
								self.profileItem.first_name = anItem["first_name"] as? String
								self.profileItem.last_name = anItem["last_name"] as? String
//								self.profileItem.profile_picture = anItem["profile_picture"] as? String
								self.profileItem.profile_picture = "https://i.imgflip.com/6kcv.jpg"
							}
							
							DispatchQueue.main.async(execute: {
								self.populateViews()
							})
							
						} catch{
							print("json error")
						}
					}
				}
			}
			task.resume()
		}
	}
	
}
