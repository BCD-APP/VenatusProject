
//
//  GameCell.swift
//  Venatus
//
//  Created by Douglas on 4/25/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    @IBOutlet var gameImage: UIImageView!
    var gameImageName: String?{
        didSet{
            if let gameImageName = gameImageName{
                gameImage.image = UIImage(named: gameImageName)
            }
        }
    }
}
