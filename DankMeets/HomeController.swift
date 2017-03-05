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
		
		setupCollectionView()
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

