//
//  Profile.swift
//  Venatus
//
//  Created by Douglas on 3/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class Profile{
    
    static let Ven_UserProfile = Profile() //Definitely refactor this and everything related to this singleton. As it stands theres no clearing data on logout and resetting program state
    
    var name: String?
    var dateOfBirth: NSDate?
    var username: String?
    var avatar: UIImage?
    
    var games: [Game]?
    
    var image1: UIImageView?
    var image2: UIImageView?
    
    func addImage1(addImage: UIImageView){
        image1 = addImage
    }

    
    
    
    func addGameToProfile(gameToAdd: Game){
        if self.games == nil{
            self.games = [Game]() //create an empty array to add to
        }
        print("Adding game: \(gameToAdd) named \(gameToAdd.gameName)")
        self.games?.append(gameToAdd)
    }
    
    func resetGames(){
        self.games = nil
    }
    
    func grabTags()->[String]{
        var returnArray = [String]()
        if let games = games{
            for gameObj in games{
                if let inputString = gameObj.gameName{
                    returnArray.append(inputString)
                    print("Debug grab tag in Profile: \(returnArray)")
                }
            }
        }
        return returnArray
    }
    
}
