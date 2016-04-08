//
//  MainViewController.swift
//  Venatus
//
//  Created by Douglas on 3/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let client = TwitterClient.sharedInstance
    
    var newsArray: [News]?

    var tempArray: [Tweets]?
    
    @IBOutlet var createEventButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var button1: UIButton! //button to test functions. Used for hacking refactor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if self.revealViewController() != nil {

            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton) { //Hack for now Refactor?
        let qSearchParameterArray = Profile.Ven_UserProfile.grabTags()
        
        //Refactor. the following is just a hack
        var query: String?
        for tags in qSearchParameterArray{
            query = tags
        }
        if let _ = query{
            query = "LeagueOfLegends" // once again just a hack for MFA REFACTOR to prevent crashes while keeping syntax
        }
        //replace first line with query of choice taking in a String
        client.searchTweetWithQuery(query, success: { (searchResults:[Tweets]) -> () in
            self.tempArray = searchResults
            print("Search results : ")
            print(searchResults)
            self.tableView.reloadData()

        }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
        cell.newsLabel.text = String(tempArray![indexPath.row].text!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tempArray = tempArray{
            return tempArray.count
        }else{
            return 0
        }
    }

    

}
