//
//  TwitchObject.swift
//  Venatus
//
//  Created by Douglas on 4/28/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class TwitchObject: NSObject {
    var zhi_name: String?
    var zhi_previewString: String?
    
    func setName(name: String){
        let twitchName = "https://www.twitch.tv/" + name
        zhi_name = twitchName
    }
    func setPreviewString(name: String){
        zhi_previewString = name
    }
}
