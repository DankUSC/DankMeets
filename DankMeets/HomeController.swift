//
//  ViewController.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	let profilePageId = "profilePageId"
	let mapPageId = "mapPageId"
	let feedPageId = "feedPageId"
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupNavigationBar()
		setupCollectionView()
	}
	
	fileprivate func setupNavigationBar(){
		navigationItem.title = "DankMeets"
		navigationController?.navigationBar.isTranslucent = false
		
		let titleLabel = UILabel(frame: CGRect(x: view.frame.width/2, y:0, width:view.frame.width - 32, height:view.frame.height))
		titleLabel.text = "DankMeets"
		titleLabel.textAlignment = NSTextAlignment.center
		titleLabel.textColor = UIColor.black
		
		let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollToMap))
		tapGesture.numberOfTapsRequired = 1
		titleLabel.isUserInteractionEnabled =  true
		titleLabel.addGestureRecognizer(tapGesture)
		titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
		navigationItem.titleView = titleLabel
		
		let profileButton = UIButton(type: .custom)
		profileButton.setImage(#imageLiteral(resourceName: "profile"), for: .normal)
		profileButton.frame = CGRect(x:0, y:0, width:30, height:30)
		profileButton.addTarget(self, action: #selector(scrollToProfile), for: .touchUpInside)
		let profileItem = UIBarButtonItem(customView: profileButton)
		
		let feedButton = UIButton(type: .custom)
		feedButton.setImage(#imageLiteral(resourceName: "feed"), for: .normal)
		feedButton.frame = CGRect(x:0, y:0, width:30, height:30)
		feedButton.addTarget(self, action: #selector(scrollToFeed), for: .touchUpInside)
		let feedItem = UIBarButtonItem(customView: feedButton)
		
		navigationItem.setLeftBarButton(profileItem, animated: false)
		navigationItem.setRightBarButton(feedItem, animated: false)
	}
	
	func setupCollectionView(){
		if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .horizontal
			flowLayout.minimumLineSpacing = 0
		}
		collectionView?.indicatorStyle = UIScrollViewIndicatorStyle.black
		collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, view.frame.height - 70, 0)
		collectionView?.backgroundColor = UIColor.white
		
		collectionView?.register(ProfilePage.self, forCellWithReuseIdentifier: profilePageId)
		collectionView?.register(MapPage.self, forCellWithReuseIdentifier: mapPageId)
		collectionView?.register(FeedPage.self, forCellWithReuseIdentifier: feedPageId)
		
		collectionView?.isPagingEnabled = true
	}
	
	func scrollToProfile(){
		scrollToMenuIndex(menuIndex: 0, animated: true)
	}
	
	func scrollToMap(){
		scrollToMenuIndex(menuIndex: 1, animated: true)
	}
	
	func scrollToFeed(){
		scrollToMenuIndex(menuIndex: 2, animated: true)
	}
	
	func scrollToMenuIndex(menuIndex : Int, animated : Bool){
		let indexPath = IndexPath(item: menuIndex, section: 0)
		collectionView?.scrollToItem(at: indexPath, at: [], animated: animated)
		collectionView?.flashScrollIndicators()
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.item == 0 {
			return collectionView.dequeueReusableCell(withReuseIdentifier: profilePageId, for: indexPath)
		} else if indexPath.item == 1 {
			return collectionView.dequeueReusableCell(withReuseIdentifier: mapPageId, for: indexPath)
		} else if indexPath.item == 2 {
			return collectionView.dequeueReusableCell(withReuseIdentifier: feedPageId, for: indexPath)
		} else {
			print("ERROR: Unexpected page ID, showing Home.")
			return collectionView.dequeueReusableCell(withReuseIdentifier: mapPageId, for: indexPath)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: view.frame.height/*-64*/)
	}
	
	
}

