//
//  ViewController.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit
import MapKit

class HomeController: UICollectionViewController, MKMapViewDelegate, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    var window : UIWindow?
    var mapView : MKMapView?
    
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
	
	let cellId = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupNavigationBar()
		setupCollectionView()
<<<<<<< Updated upstream
		setupMenuBar()
        
        //setting up map
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        
        self.mapView = MKMapView(frame: CGRect(x:0, y:20, width: view.frame.width, height: view.frame.width))
        self.view.addSubview(self.mapView!)
        
        //getting permissions to display your location on the map
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
        
=======
>>>>>>> Stashed changes
	}
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, self.distanceSpan, self.distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
        }
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
		
		collectionView?.isPagingEnabled = true
		
		collectionView?.addSubview(profilePage)
		collectionView?.addSubview(mapPage)
		collectionView?.addSubview(feedPage)
		
//		collectionView?.contentOffset = CGPoint(x: view.frame.width, y: 0)
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

