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
	let profilePageId = "profilePageId"
	let mapPageId = "mapPageId"
	let feedPageId = "feedPageId"
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupNavigationBar()
		setupCollectionView()
	}
	
	let menuBar : MenuBar = {
		let mb = MenuBar()
		return mb
	}()
	
	let profilePage : ProfilePage = {
		let profilePage = ProfilePage()
		return profilePage
	}()
	
	let mapPage : MapPage = {
		let mapPage = MapPage()
		return mapPage
	}()
	
	let feedPage : FeedPage = {
		let feedPage = FeedPage()
		return feedPage
	}()
	
	fileprivate func setupMenuBar(){
		view.addSubview(menuBar)
		view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
		view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
	}
	
	fileprivate func setupNavigationBar(){
		navigationItem.title = "DankMeets"
		navigationController?.navigationBar.isTranslucent = false
		
		let titleLabel = UILabel(frame: CGRect(x: view.frame.width/2, y:0, width:view.frame.width - 32, height:view.frame.height))
		titleLabel.text = "DankMeets"
		titleLabel.textColor = UIColor.black
		titleLabel.center = view.center
		titleLabel.target(forAction: #selector(scrollToMap), withSender: [])
		
		let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollToMap))
		tapGesture.numberOfTapsRequired = 1
		titleLabel.isUserInteractionEnabled =  true
		titleLabel.addGestureRecognizer(tapGesture)
		titleLabel.font = UIFont.systemFont(ofSize: 20)
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
		
		collectionView?.backgroundColor = UIColor.white
		
		collectionView?.register(Page.self, forCellWithReuseIdentifier: cellId)
		collectionView?.register(ProfilePage.self, forCellWithReuseIdentifier: profilePageId)
		collectionView?.register(MapPage.self, forCellWithReuseIdentifier: mapPageId)
		collectionView?.register(FeedPage.self, forCellWithReuseIdentifier: feedPageId)
		
		collectionView?.isPagingEnabled = true
		
		collectionView?.addSubview(profilePage)
		collectionView?.addSubview(mapPage)
		collectionView?.addSubview(feedPage)
		
		scrollToMap()
	}
	
	func scrollToProfile(){
		let indexPath = IndexPath(item: 0, section: 0)
		collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
	}
	
	func scrollToMap(){
		let indexPath = IndexPath(item: 1, section: 0)
		collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
	}
	
	func scrollToFeed(){
		let indexPath = IndexPath(item: 2, section: 0)
		collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
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
		}
		
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

