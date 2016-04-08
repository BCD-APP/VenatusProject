//
//  User.swift
//  Venatus
//
//  Created by Douglas on 4/7/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class User: NSObject {
    static let userDidLogoutNotification = "UserDidLogout"
    
    
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSURL?
    var user_description: NSString?
    
    var user_origDictionary: NSDictionary?
    
    
    init(dictionary: NSDictionary){
        self.user_origDictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profie_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profileURL = NSURL(string: profileURLString)
        }
        user_description = dictionary["description"] as? String
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get{
        if _currentUser == nil{
        let defaults = NSUserDefaults.standardUserDefaults()
        let userData = defaults.objectForKey("currentUserData") as? NSData
        if let userData = userData{
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
        _currentUser = User(dictionary: dictionary) // reinit User if we have
        }
        }//end if _currentUser
        return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user{
                let data = try! NSJSONSerialization.dataWithJSONObject(user.user_origDictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
                //save user as a JSON (original non inited format.
                
            }else {
                defaults.setObject(nil, forKey: "currentUserData")
                
            }
            
            defaults.synchronize()
        }
    }
    
}
