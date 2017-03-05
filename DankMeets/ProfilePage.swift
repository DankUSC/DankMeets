//
//  ProfilePage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class ProfilePage : Page, UICollectionViewDataSource, UICollectionViewDelegate {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.gray
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
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
                            for anItem in json as! [Dictionary<String, Any>] {
                                let profItem = ProfileItem()
                                profItem.friend_count = anItem["friend_count"]
                                profItem.fname = anItem["first_name"] as! String?
                                profItem.lname = anItem["last_name"] as! String?

                            }
                            DispatchQueue.main.async(execute: {
                                self.collectionView.reloadData()
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
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        
//        cell.meetItem = feedItems[indexPath.item] as? MeetItem
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
}
