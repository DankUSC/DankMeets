//
//  ProfilePage.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class ProfilePage : Page {
    
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
