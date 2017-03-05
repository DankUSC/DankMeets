//
//  MapPage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

class MapPage : Page, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, CLLocationManagerDelegate {
	
	var mapView : MKMapView?
	var locationManager: CLLocationManager?
	
	let nearbyCellId = "nearbyCellId"
	
	lazy var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = UIColor.white
		cv.dataSource = self
		cv.delegate = self
		return cv
	}()
	
	var nearbyItems: [NearbyItem] = {
		return []
	}()
	
	override func setupViews() {
		super.setupViews()
		
		if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.minimumLineSpacing = 0
		}
		
		collectionView.register(NearbyCell.self, forCellWithReuseIdentifier: nearbyCellId)
		
		mapView = MKMapView(frame: CGRect(x:20, y:20, width: frame.width-40, height: 280))
		addSubview(mapView!)
		addSubview(collectionView)
		
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
		
		addConstraintsWithFormat("H:|[v0]|", views: collectionView)
		addConstraintsWithFormat("V:|-320-[v0]|", views: collectionView)
		addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: mapView!, attribute: .bottom, multiplier: 1, constant: 20))
		
//		addConstraint(NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: frame, attribute: .bottom, multiplier: 1, constant: 0))
		
		//sending http request to server to obtain data
		let urlString = URL(string: "https://dank-meets.appspot.com/nearby/1")
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
								let nearbyItem = NearbyItem()
								nearbyItem.user = anItem["user"] as? String
								nearbyItem.lat = anItem["lat"] as? Double
								nearbyItem.lon = anItem["lon"] as? Double
								self.nearbyItems.append(nearbyItem)
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
	
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
		
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        self.mapView?.setRegion(region, animated: true)
        self.mapView?.showsUserLocation = true
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return nearbyItems.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nearbyCellId, for: indexPath) as! NearbyCell
		
		cell.nearbyItem = nearbyItems[indexPath.item] as NearbyItem
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width, height: 200)
	}

}
