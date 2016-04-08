//
//  TwitterClient.swift
//  Venatus
//
//  Created by Douglas on 3/17/16.
//  Copyright © 2016 Dougli. All rights reserved.
//
import UIKit
import BDBOAuth1Manager


let twitterConsumerKey = "A6RcdHSxPjh1h7wZXcnd4rQ1V"
let twitterConsumerSecret = "NkIjqkB90R1Ot11HQw0Gc3CdKM8FN7OBNkRqSXYnusn7LzYKbE"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")




class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    
    
    
    var loginSuccess: (() -> ())? //declaring an optional closure
    var loginFailure: ((NSError) -> ())? //optional of an NSError that returns nothing
    
    
    
    func homeTimeline(success:([Tweets])-> (), failure: (NSError)->() ){ //Closure inside parameters, means i'd like a parameter with closure of what to do with the [Tweets] that is denoted by success and in case of failure give what the NSError is
        
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            //get hometimeline
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweets.tweetsWithArray(dictionaries)
            success(tweets) // in the case of a success we hand back the tweets
            }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error) // in the case of a failure we hand back the failure
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //On success of verify credentials
            //print(response)
            //^ Response is user dictionary full of json information of the user
            let userDictionary = response as! NSDictionary
            let thisUser = User(dictionary: userDictionary)
            success(thisUser) //returns thisUser (User object) under success
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                //print failure block
                //print(error.localizedDescription)
                failure(error) //return error under failure
        })
    }
    
    func login(success: ()->(), failure: (NSError)->()){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "VenatusApp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            //Run this block if we get request token
            print("Token Get")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(url!)
            
            }) { (error:NSError!) -> Void in
                //Run this block if failure
                print(error.localizedDescription)
                self.loginFailure?(error)
        }//end failure block
        
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: self)
    }
    
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            //Do success stuff in this b lock
            print("On Success, login success GET")
            self.currentAccount({ (successUser: User) -> () in
                User.currentUser = successUser
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            }) { (error: NSError!) -> Void in
                //do error stuff in this block
                print(error.localizedDescription)
                self.loginFailure?(error)
        }
    }
    
    //Refactor to take a q of [String] and handle it
    func searchTweetWithQuery(q: String?, success: ([Tweets])->(), failure: (NSError)->()){
        var parameters = [String : String]()
        if let q = q{
            parameters["q"] = q
        }
        print("Parameter is: \(parameters)")
        GET("1.1/search/tweets.json", parameters: parameters, progress: nil, success: { (session:NSURLSessionDataTask, response:AnyObject?) -> Void in
            //Success return should have tweets with search query
            
            print("Inside twitterClient")
            let dictionaries = response!["statuses"] as! [NSDictionary]//response is given in a [JSON:JSON] Format, statuses seperates it into what we want
            let tweets = Tweets.tweetsWithArray(dictionaries)
            success(tweets) // in the case of a success we hand back the tweets
            }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
    }
}

    
    