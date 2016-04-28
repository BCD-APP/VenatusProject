//
//  Events.swift
//  Venatus
//
//  Created by Douglas on 4/20/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class Events: NSObject {
    static let zhi_instance = Events()
    
    var z_title: String?
    var z_who: String?
    var z_what: String?
    var z_where: String?
    var z_when: String?
    var z_why: String?
    var z_image: UIImage?
    
    var z_details: String?
    
    var z_Events: [String] = []
    
    func eventCreated(){
        z_Events.append(createEventString())
    }
    
    func createEventString()->String{
        var array:[String] = []
        if let z_who = z_who{
            array.append("Who: " + z_who)
        }
        if let z_what = z_what{
            array.append("What: " + z_what)
        }
        if let z_where = z_where{
            array.append("Where: " + z_where)
        }
        if let z_when = z_when{
            array.append("When: " + z_when)
        }
        if let z_why = z_why{
            array.append("Why: " + z_why)
        }
        let newString = array.joinWithSeparator("\n")
        print(newString)
        return newString
    }
}
