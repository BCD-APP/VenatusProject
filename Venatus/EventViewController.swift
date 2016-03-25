//
//  EventViewController.swift
//  Venatus
//
//  Created by Douglas on 3/24/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

protocol EventViewControllerDelegate : class{
    func locationPicked(controller: EventViewController, latitude: Double, longitude: Double)
}

class EventViewController: UIViewController {

    
    
    @IBOutlet var createEventButton: UIButton!
    
    weak var delegate : EventViewControllerDelegate!
    var lat: Double?
    var lon: Double?
    //var vc: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func finishCreatingEvent(sender: UIButton) {
        delegate.locationPicked(self, latitude: lat!, longitude: lon!)
    }


}
