//
//  PopViewController.swift
//  Venatus
//
//  Created by Douglas on 4/26/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentText: UITextView!
    @IBOutlet var contentImage: UIImageView!
    
    var popTwitchObject: TwitchObject?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStreamSegue(){
        print("SETTING STREAM SEGUE")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedImage:")
        contentImage.userInteractionEnabled = true
        tapGestureRecognizer.numberOfTapsRequired = 2
        contentImage.addGestureRecognizer(tapGestureRecognizer)
    }

    func tappedImage(sender: UITapGestureRecognizer){
        print("TEST")
        performSegueWithIdentifier("twitchSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "twitchSegue"{
            let vc = segue.destinationViewController as! TwitchViewController
            vc.twitchString = popTwitchObject?.zhi_name
            print(vc.twitchString)
        }
    }


}
