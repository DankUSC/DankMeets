//
//  FeedItem.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class FeedItem: NSObject {
	
	var time : Date?
	var event : String?
	
}

class MeetItem: FeedItem {
	
	var username1 : String?
	var username2 : String?
	var selfieURL : String?
	
}

class EventItem: FeedItem {
	
	var username : String?
	
}
