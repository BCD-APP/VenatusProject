//
//  ViewEventViewController.swift
//  Venatus
//
//  Created by Douglas on 4/26/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class ViewEventViewController: UIViewController {

    @IBOutlet var zh_title: UILabel!
    @IBOutlet var zh_who: UITextView!
    @IBOutlet var zh_what: UITextView!
    @IBOutlet var zh_where: UITextView!
    @IBOutlet var zh_when: UITextView!
    @IBOutlet var zh_why: UITextView!

    
    @IBOutlet var eventImage: UIImageView!
    
    let Singleton = Events.zhi_instance
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSingletons()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setSingletons(){
        print(Singleton)
        if let Zpicture = Singleton.z_image{
            eventImage.image = Zpicture
        }
        if let Ztitle = Singleton.z_title{
            zh_title.text = Ztitle
        }
        if let Zwho = Singleton.z_who{
            zh_who.text = Zwho
        }
        if let Zwhat = Singleton.z_what{
            zh_what.text = Zwhat
        }
        if let Zwhere = Singleton.z_where{
            zh_where.text = Zwhere
        }
        if let Zwhen = Singleton.z_when{
            zh_when.text = Zwhen
        }
        if let zWhy = Singleton.z_why{
            zh_why.text = zWhy
        }
    }

}
