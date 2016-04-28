//
//  TwitchData.swift
//  Venatus
//
//  Created by Douglas on 4/28/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class TwitchData: NSObject {
    static let sharedInstance = TwitchData()
    
    var array: [TwitchObject] = []
    
    
    func grabJSON(query: String?){
        var requestURL: NSURL?
        /*if let query = query{
        requestURL = NSURL(string: "https://api.twitch.tv/kraken/search/streams?q=\(query)&limit=15")
        }*/
        
        //let requestURL: NSURL = NSURL(string: "https://api.twitch.tv/kraken/streams")!
        requestURL = NSURL(string: "https://api.twitch.tv/kraken/search/streams?q=league%20of%20legends&limit=15")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL!)
        let session = NSURLSession.sharedSession()
        print("BOOP")
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            print("SESSION")
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            print("CODE: \(statusCode)")
            if (statusCode == 200) {
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let stations = json["streams"] as? [[String: AnyObject]] {
                        
                        
                        for station in stations {
                            let obj = TwitchObject()
                            //print(station)
                            //print(station["preview"])
                            
                            if let preview = station["preview"] as? [String: AnyObject]{
                                //print(preview["medium"])
                                //obj.setPreviewString(preview["medium"])
                                if let medImg = preview["medium"]{
                                    print(medImg)
                                    obj.setPreviewString(medImg as! String)
                                }
                            }
                            
                            if let channels = station["channel"] as? [String: AnyObject]{
                                if let channelName = channels["name"]{
                                    obj.setName(channelName as! String)
                                    
                                }
                            }
                            self.array.append(obj)
                        }//for station in stations
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                    
                }
                
            }
            
        }
        
        task.resume()
    }

}
