//
//  TwitchViewController.swift
//  Venatus
//
//  Created by Douglas on 4/28/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class TwitchViewController: UIViewController {


    var twitchString: String?
    
    @IBOutlet var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(NSURLRequest(URL: NSURL(string: twitchString!)!))

    }


    



}
