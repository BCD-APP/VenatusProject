//
//  Tiles.swift
//  Venatus
//
//  Created by Douglas on 4/26/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class Tiles: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var zh_title: UILabel!
    @IBOutlet var zh_content: UIImageView!
    
    var tileObj = TileObj()
    
    var zh_twitchObject: TwitchObject?
    
    var z_labelText: String?{
        didSet{
            if let labelText = z_labelText{
                zh_title.text = labelText
            }
        }
    }
    
    var z_contentSet: UIImage?{
        didSet{
            if let contentSet = z_contentSet{
                zh_content.image = contentSet
            }
        }
    }
    
    var z_contentText: String?//{
    /*didSet{
    if let contentText = z_contentText{
    //zhi_text.text = contentText
    }
    }*/
    //}
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "Tiles", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        zh_content.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.backgroundColor = UIColor.grayColor()
        zh_content.clipsToBounds = true
        addSubview(contentView)
    }
    
    func setText(text: String){
        z_contentText = text
    }
    func setTileContentImage(image: UIImage?, imageStr: String?){
        if let image = image{
            print("SET IMAGE")
            z_contentSet = image
        }
        if let imageStr = imageStr{
            zh_content.setImageWithURL(NSURL(string: imageStr)!)
        }
    }
    func setTitle(text: String){
        z_labelText = text
    }
    func setSpecialData(special: TwitchObject){
        zh_twitchObject = special
    }
}
