//
//  SharingPosts.swift
//  InstagramProject
//
//  Created by YouGotToFindWhatYouLove on 3/6/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit
import Parse

class SharingPosts: NSObject {
    var posts: [PFObject]!
    static let sharedInstance = SharingPosts()
}
