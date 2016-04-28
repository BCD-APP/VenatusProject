//
//  EventViewController.swift
//  Venatus
//
//  Created by Douglas on 3/24/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

protocol EventViewControllerDelegate : class{
    func locationPicked(controller: EventViewController, latitude: Double, longitude: Double, title: String?, image: UIImage?)
}

class EventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet var createEventButton: UIButton!
    @IBOutlet var takePhoto: UIButton!
    @IBOutlet var useLibrary: UIButton!
    @IBOutlet var pictureView: UIImageView!
    
    
    weak var delegate : EventViewControllerDelegate!
    var lat: Double?
    var lon: Double?
    var vc: UIImagePickerController?
    
    let Singleton = Events.zhi_instance

    /**
     * The W's
     */
    
    @IBOutlet var zh_title: UITextView!
    @IBOutlet var zh_who: UITextField!
    @IBOutlet var zh_what: UITextField!
    @IBOutlet var zh_where: UITextField!
    @IBOutlet var zh_when: UITextField!
    @IBOutlet var zh_why: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc = UIImagePickerController()
        vc!.delegate = self
        vc!.allowsEditing = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setImageAction(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            vc!.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(vc!, animated: true, completion: nil)
        }else{
            vc!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(vc!, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // Do something with the images (based on your use case)
            //avatarImage.image = editedImage
            pictureView.image = originalImage
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func finishCreatingEvent(sender: UIButton) {
        var Ztitle: String = "No name"
        if let newtitle = zh_title.text{
            if newtitle != ""{
                Ztitle = newtitle
            }
        }
        setSingletons()
        delegate.locationPicked(self, latitude: lat!, longitude: lon!, title: Ztitle, image: pictureView.image)
    }
    
    func setSingletons(){
        if let Zimage = pictureView.image{
            Singleton.z_image = Zimage
        }
        if let Ztitle = zh_title.text{
            Singleton.z_title = Ztitle
        }
        if let Zwho = zh_who.text{
            Singleton.z_who = Zwho
        }
        if let Zwhat = zh_what.text{
            Singleton.z_what = Zwhat
        }
        if let Zwhere = zh_where.text{
            Singleton.z_where = Zwhere
        }
        if let Zwhen = zh_when.text{
            Singleton.z_when = Zwhen
        }
        if let zWhy = zh_why.text{
            Singleton.z_why = zWhy
        }
    }

    @IBAction func takePhotoButton(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            vc!.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func useLibraryButton(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            vc!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(vc!, animated: true, completion: nil)
        }
    }
    
}
