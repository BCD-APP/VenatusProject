//
//  Tweet.swift
//  Venatus
//
//  Created by Brian on 3/16/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: String?
    var retweetCount: Int
    var heartCount: Int
    
    var didRetweet = false
    var didFavorite = false
    
    
    init(dictionary: NSDictionary){
        print("============================RESETTING==============")
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        id = String(dictionary["id_str"]!)
        retweetCount = dictionary["retweet_count"] as! Int
        heartCount = dictionary["favorite_count"] as! Int
        
        didRetweet = dictionary["retweeted"] as! Bool
        print("=================Text: \(text)===============")
        print("====================didRetweet: \(didRetweet)===========")
        didFavorite = dictionary["favorited"] as! Bool
        print("====================didLike: \(didFavorite)===========")
        
    }
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
    
}
