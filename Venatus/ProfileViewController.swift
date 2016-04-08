//
//  ProfileViewController.swift
//  Venatus
//
//  Created by Douglas on 3/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var photoLibraryButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var setAvatarButton: UIButton!
    @IBOutlet var avatarImage: UIImageView!
    
    
    @IBOutlet var gameTextfield: UITextField! //Refactor into drop down menu of options
    @IBOutlet var addGameButton: UIButton! //Maybe refactor probably not
    
    
    var vc: UIImagePickerController?
    var imageOrig: UIImage?

    
    @IBOutlet var birthdayLabel: UILabel!
    
    let user = PFUser.currentUser()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        
        vc = UIImagePickerController()
        vc!.delegate = self
        vc!.allowsEditing = true
        // Do any additional setup after loading the view.
        if let avatar = user?.valueForKey("avatar") as? PFFile{
            avatar.getDataInBackgroundWithBlock(){(imageData: NSData?, error: NSError?)->Void in
                if(error == nil){
                    print("Set avatar display")
                    self.avatarImage.image = UIImage(data: imageData!)
                }else{
                    print("At this point, logically, theres no avatar image so we just leave default?")
                }
                
            }
        }
        if let dob = user?.valueForKey("birthdate") as? String{
            if(dob != ""){
                birthdayLabel.text =  dob
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onSetAvatar(sender: UIButton) {

        let imageData: NSData = UIImageJPEGRepresentation(avatarImage.image!, 1.0)!
        let imageFile: PFFile = PFFile(name:"image.jpg", data:imageData)!
        imageFile.saveInBackgroundWithBlock(){(success: Bool, error: NSError?)-> Void in
            if success{
                //let user = PFUser.currentUser()
                self.user!.setObject(imageFile, forKey: "avatar")
                print("Potato")
                self.user!.saveInBackgroundWithBlock(){(success: Bool, error:NSError?)->Void in
                    if success{
                        print("Saved")
                    }else{
                        print(error)
                    }
                    
                }
            }else{
                print(error)
            }
        }

    }
    
    
    @IBAction func onTakePhoto(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            vc!.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(vc!, animated: true, completion: nil)
        }else{
            print("camera not available")
        }
    }
    
    
    @IBAction func onSelectPhoto(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            vc!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(vc!, animated: true, completion: nil)
        }else{
            print("photo library not available")
        }
    }
    
    
    @IBAction func onLogout(sender: UIButton) {
        PFUser.logOut()
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            avatarImage.image = editedImage
            imageOrig = originalImage
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addGameClicked(sender: UIButton) {
        let nameOfGame = gameTextfield.text
        if let nameOfGame = nameOfGame{
            print("Creating game to add")
            let gameToAdd = Game(NameOfGame: nameOfGame)
            print("Adding game")
            Profile.Ven_UserProfile.addGameToProfile(gameToAdd)
        }else{
            print("Field is nil nothing added")
        }
    }
    

    

}
