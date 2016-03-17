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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onRegistration(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameTextField.text
        print(usernameTextField.text)
        newUser.password = passwordTextField.text
        print(passwordTextField.text)
        print(newUser)
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
                    print(error?.localizedDescription)
                    
                }
            }
        })
    }
}
