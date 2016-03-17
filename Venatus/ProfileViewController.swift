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
    
    
    
    var vc: UIImagePickerController?
    var imageOrig: UIImage?

    
    
    
    
    
    
    
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
    
    
    
    @IBAction func onSetAvatar(sender: UIButton) {
        //let newImage = Post.resize(avatarImage.image!, newSize: CGSize(width:100, height:100))
        //let PFAvatar = Post.getPFFileFromImage(newImage))
        let imageData: NSData = UIImageJPEGRepresentation(avatarImage.image!, 1.0)!
        let imageFile: PFFile = PFFile(name:"image.jpg", data:imageData)!
        imageFile.saveInBackgroundWithBlock(){(success: Bool, error: NSError?)-> Void in
            print("First completion block")
            if success{
                print("First completion block v")
                let user = PFUser.currentUser()
                user!.setObject(imageFile, forKey: "avatar")
                print("Potato")
                user!.saveInBackgroundWithBlock(){(success: Bool, error:NSError?)->Void in
                    print("Second Completion block")
                    if success{
                        print("Secomd completion block v")
                        print("Saved")
                    }else{
                        print("error again")
                        //print(error)
                    }
                    
                }
            }else{
                print("ERROR")
                print(error)
            }
        }
        //user!["avatar"] = PFAvatar

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
    
    

    

}
