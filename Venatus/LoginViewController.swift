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
        //let steamClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://http://api.steampowered.com"))
        print("Currently Inactive")
    
    }
    
    
    
    
    @IBAction func onSignIn(sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                let alert = UIAlertController(title: "Notice", message: "We would like to access your twitter account to fill your news feed with relevant data from twitter. Not signing in and authorizing Twitter only prevents news from loading in for the current session.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok let me sign in!", style: .Default) { _ in
                    TwitterClient.sharedInstance.login({ () -> () in
                        self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                    }, failure: { (error:NSError) -> () in
                            print(error.localizedDescription)
                    })
                })//end alert Action1
                alert.addAction(UIAlertAction(title: "No Thanks!", style: .Default) { _ in
                    self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                })//Perform loggedInSegue in both scenerios
                self.presentViewController(alert, animated: true){}
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    
    @IBAction func onRegister(sender: UIButton) {
        performSegueWithIdentifier("RegistrationSegue", sender: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Start segue")
        if(segue.identifier == "LoggedInSegue"){
            //Do things if we're segueing using LoggedInSegue
            
        }//end if segue logged in segue
        print("nearing end segue")
    }
    
    
}
