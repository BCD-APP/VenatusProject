//
//  RegistrationViewController.swift
//  Venatus
//
//  Created by Douglas on 3/16/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var registerButton: UIButton!
    
    
    @IBOutlet var backButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    @IBAction func onRegistration(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameTextField.text
        print(usernameTextField.text)
        newUser.password = passwordTextField.text
        print(passwordTextField.text)
        print(newUser)
        //newUser["avatar"] = Post.getPFFileFromImage(avatarImage.image!)
        newUser.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?)-> Void in
            print(newUser)

            if success{
                print("Created a user")
                self.performSegueWithIdentifier("RegisteredSegue", sender: self)
                
            }//end if success
            else{
                if error?.code == 202{
                    print("Username is taken")
                }else{
                    print(newUser)
                    print("ERROR")
                    print(error?.localizedDescription)
                    
                }
            }
        })
    }
    
    
    @IBAction func onBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
