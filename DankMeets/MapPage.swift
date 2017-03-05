//
//  MapPage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

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
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.requestAlwaysAuthorization()
//			locationManager.distanceFilter = 50
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
		}
	}
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView?.setRegion(region, animated: true)
        self.mapView?.showsUserLocation = true
    }

}
