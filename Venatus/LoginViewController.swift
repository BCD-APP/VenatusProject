//
//  LoginViewController.swift
//  Venatus
//
//  Created by Douglas on 3/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import Parse


class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBOutlet var signInButton: UIButton!
    
    
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var steamButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func onSteamLogin(sender: UIButton) {
        let steamClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://http://api.steampowered.com"))
    
    }
    
    
    
    
    @IBAction func onSignIn(sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    
    @IBAction func onRegister(sender: UIButton) {
        performSegueWithIdentifier("RegistrationSegue", sender: nil)
    }

    
    
    
}
