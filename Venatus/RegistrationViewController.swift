//
//  RegistrationViewController.swift
//  Venatus
//
//  Created by Douglas on 3/16/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var registerButton: UIButton!
    
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var dobPicker: UIPickerView!
    
    
    let monthArray = ["Month", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let dayArray1 = ["Day","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    let dayArray2 = ["Day","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    let dayArrayLeap = ["Day","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29"]
    let dayArrayNonLeap = ["Day","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"]
    let yearArray = ["Year","1950","1951","1952","1953","1954","1955","1956","1957","1958","1959","1960","1961","1962","1963","1964","1965","1966","1967","1968","1969","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015"]
    let dayList = ["1", "2", "3", "4"]
    
    var dayCheck = 0
    
    var leap = false
    
    var feb = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dobPicker.delegate = self
        dobPicker.dataSource = self
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
    
    /* Picker View Stuff*/
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component){
        case 0:
            return monthArray.count
        case 1:
            switch(dayCheck){
            case 0:
                return dayArray1.count
            case 1:
                return dayArray2.count
            case 2:
                return dayArrayLeap.count
            case 3:
                return dayArrayNonLeap.count
            default:
                break
            }//end inner switch
        case 2:
            return yearArray.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(component){
        case 0:
            return monthArray[row]
        case 1:
            switch(dayCheck){
            case 0:
                return dayArray1[row]
            case 1:
                return dayArray2[row]
            case 2:
                return dayArrayLeap[row]
            case 3:
                return dayArrayNonLeap[row]
            default:
                break
            }//end inner switch
        case 2:
            return yearArray[row]
        default:
            break
        }
        return dayArray1[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component)
        switch(component){
        case 0:
            switch(row){
            case 0:
                dayCheck = 0
                feb = false
            case 1:
                dayCheck = 0
                feb = false
            case 2:
                print("LEAP CHECK \(leap)")
                if(leap){
                    dayCheck = 2
                }else{
                    dayCheck = 3
                }
                feb = true
                //FEB STUFF
            case 3:
                dayCheck = 0
                feb = false
            case 4:
                dayCheck = 1
                feb = false
            case 5:
                dayCheck = 0
                feb = false
            case 6:
                dayCheck = 1
                feb = false
            case 7:
                dayCheck = 0
                feb = false
            case 8:
                dayCheck = 0
                feb = false
            case 9:
                dayCheck = 1
                feb = false
            case 10:
                dayCheck = 0
                feb = false
            case 11:
                dayCheck = 1
                feb = false
            case 12:
                dayCheck = 0
                feb = false
            default:
                break
            }
            
        case 2:
            if(feb){
                var year = 9 + row //9 is to match the array hard coding
                year = year % 4
                if(year == 0){
                    //leap year
                    leap = true
                    dayCheck = 2
                }
                else{
                    leap = false
                    dayCheck = 3
                }//end if year
            }//end if feb
        default:
            break
        }
        dobPicker.reloadComponent(1)
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var string = "Potato"
        switch(component){
        case 0:
            string = monthArray[row]
        case 1:
            switch(dayCheck){
            case 0:
                string = dayArray1[row]
            case 1:
                string = dayArray2[row]
            case 2:
                string =  dayArrayLeap[row]
            case 3:
                string = dayArrayNonLeap[row]
            default:
                break
            }//end inner switch
        case 2:
            string = yearArray[row]
        default:
            break
        }
        return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
    }
    
}
