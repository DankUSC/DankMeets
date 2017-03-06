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
	var myLocation : CLLocationCoordinate2D?
	
	let nearbyCellId = "nearbyCellId"
	
	lazy var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = UIColor.white
		cv.dataSource = self
		cv.delegate = self
		return cv
	}()
	
	let nearbyTextLabel : UILabel = {
		let label = UILabel()
		label.text = "Nearby People"
		label.textColor = UIColor.gray
		label.font = UIFont.systemFont(ofSize: 12)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
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
		mapView?.layer.borderWidth = 2
		mapView?.layer.borderColor = UIColor.black.cgColor
		mapView?.layer.cornerRadius = 20
		
		addSubview(mapView!)
		addSubview(nearbyTextLabel)
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
		addConstraintsWithFormat("H:|-20-[v0]|", views: nearbyTextLabel)
		addConstraintsWithFormat("V:|-320-[v0]-[v1]|", views: nearbyTextLabel, collectionView)
		
		createJSONTask()
		_ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(createJSONTask), userInfo: nil, repeats: true)
	}
	
	func pinFriends(){
		mapView?.removeAnnotations((mapView?.annotations)!)
		for friend in nearbyItems {
			let annotation = MKPointAnnotation()
			annotation.coordinate = CLLocationCoordinate2D(latitude: friend.lat!, longitude: friend.lon!)
			annotation.title = friend.user
			let point1 = MKMapPointForCoordinate(annotation.coordinate)
			let point2 = MKMapPointForCoordinate(myLocation!)
			friend.distance = MKMetersBetweenMapPoints(point1, point2)
			if (friend.distance! < 5000.0) {
				mapView?.addAnnotation(annotation)
			} else {
				nearbyItems.remove(at: nearbyItems.index(of: friend)!)
			}
		}
	}
	
	func createJSONTask(){
		nearbyItems.removeAll()
		
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
//							print(json)
							for anItem in json as! [Dictionary<String, Any>] {
								let nearbyItem = NearbyItem()
								nearbyItem.user = anItem["user"] as? String
								nearbyItem.lat = anItem["lat"] as? Double
								nearbyItem.lon = anItem["lon"] as? Double
								self.nearbyItems.append(nearbyItem)
							}
							
							DispatchQueue.main.async(execute: {
								self.pinFriends()
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
		
        myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: myLocation!, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
		
        self.mapView?.setRegion(region, animated: true)
        self.mapView?.showsUserLocation = true
		
		//sending location
		let urlAssembling = "https://dank-meets.appspot.com/location?user_id=1&lat=" + String(location.coordinate.latitude) + "&lon=" + String(location.coordinate.longitude)
		let urlString = URL(string : urlAssembling)
		if let url = urlString {
			let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
				if error != nil {
					print(error!)
				}
			}
			task.resume()
		}
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
		return CGSize(width: frame.width, height: 50)
	}

}
