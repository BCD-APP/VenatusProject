//
//  Profile.swift
//  Venatus
//
//  Created by Douglas on 3/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

struct Profile{
    var name: String?
    var dateOfBirth: NSDate?
    var username: String?
    var avatar: UIImage?
    
    var games: [Game]?

    
    
    
    mutating func addGameToProfile(gameToAdd: Game){
        self.games?.append(gameToAdd)
    }
    
}
