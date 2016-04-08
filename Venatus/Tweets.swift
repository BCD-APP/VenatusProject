//
//  Tweets.swift
//  Venatus
//
//  Created by Douglas on 4/7/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class Tweets: NSObject {
    
    var text: NSString?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary])->[Tweets]{
        var tweetsArray = [Tweets]()
        for dictionary in dictionaries{ // loop dictionary in dictionaries
            let inTweet = Tweets(dictionary: dictionary) // create tweet object per iterated dictionary
            tweetsArray.append(inTweet) //add inTweet (tweet object) into tweetsArray
        }
        
        return tweetsArray
        
    }
    
    
}

