//
//  FeedItem.swift
//  DankMeets
//
//  Created by Osman Kaan Demiröz on 04/03/2017.
//  Copyright © 2017 Cool. All rights reserved.
//

import UIKit

class FeedItem: NSObject {
	
	var time : NSDate?
	
}

class MeetItem: FeedItem {
	
	var username1 : String?
	var username2 : String?
	var selfie : String?
	
}

class EventItem: FeedItem {
	
	var username : String?
	var event : String?
	
}
