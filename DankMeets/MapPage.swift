//
//  MapPage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit
import MapKit

class MapPage : Page, MKMapViewDelegate, CLLocationManagerDelegate {
	
	var mapView : MKMapView?
	
	var locationManager: CLLocationManager?
	//The range (meter) of how much we want to see arround the user's location
	let distanceSpan: Double = 500
	
	override func setupViews() {
		super.setupViews()
		
		mapView = MKMapView(frame: CGRect(x:20, y:50, width: frame.width-40, height: frame.width-100))
		addSubview(mapView!)
		
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
	
}
