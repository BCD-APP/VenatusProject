//
//  MainViewController.swift
//  Venatus
//
//  Created by Douglas on 3/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import AFNetworking

class MainViewController: UIViewController, /*UITableViewDataSource, UITableViewDelegate, */UIPopoverPresentationControllerDelegate {

    let client = TwitterClient.sharedInstance
    let eventInstance = Events.zhi_instance
    
    var newsArray: [News]?

    var tempArray: [Tweets]?
    
    var streamArray: [TwitchObject]?
    
    @IBOutlet var createEventButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var button1: UIButton! //button to test functions. Used for hacking refactor?
    
    @IBOutlet var newsScroll: UIScrollView!
    @IBOutlet var eventsScroll: UIScrollView!
    @IBOutlet var streamScroll: UIScrollView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*tableView.delegate = self
        tableView.dataSource = self
        */
        if self.revealViewController() != nil {

            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        }
        // Do any additional setup after loading the view.
        /**
        * Scroll View Stuff
        */
        scrollViewPopulateNews()
        scrollViewPopulateEvents()
        scrollViewPopulateStreams()
    }
    
    func scrollViewPopulateNews(){
        let contentWidth = CGFloat(450)
        var contentHeight = CGFloat(200)
        var threecount = 0
        var allocated = 0
        var scroll1count = 0
        if let tempArray = tempArray{
            scroll1count = tempArray.count
        }
        if scroll1count > 3{
            contentHeight = CGFloat(165) * (CGFloat(scroll1count+1)/3) + CGFloat(10)//scrollView.bounds.height * 3 // change this based on # of items. CGFloat 150(tile) x ( # / 3) if # < 3 set # to 3.
        }
        newsScroll.contentSize = CGSizeMake(contentWidth, contentHeight)
        var currentXOffset = CGFloat(0)
        var currentYOffset = CGFloat(0)
        let subviewEdge = CGFloat(150)
        print("SCROLL COUNT ATM : ")
        print(scroll1count)
        while (scroll1count > allocated) {
            print("INSIDE SCROLL COUNT WHILE LOOP")
            let frame = CGRectMake(currentXOffset, currentYOffset, 150, 150).insetBy(dx: 5, dy: 5)
            createTile(frame, title: "News", content: tempArray![allocated].text as! String, scroll: newsScroll, imageStr: nil, specialData: nil)
            allocated++
            threecount = (threecount + 1) % 3
            if(threecount == 0){
                currentXOffset = CGFloat(0)
                currentYOffset += subviewEdge
            }else{
                currentXOffset += subviewEdge
            }
        }
    }
    
    func scrollViewPopulateEvents(){
        let contentWidth = CGFloat(450)
        var contentHeight = CGFloat(200)
        /* var for non demo */let scroll2count = eventInstance.z_Events.count
        var threecount = 0
        var allocated = 0
        if scroll2count > 3{
            contentHeight = CGFloat(165) * (CGFloat(scroll2count+1)/3) + CGFloat(10)//scrollView.bounds.height * 3 // change this based on # of items. CGFloat 150(tile) x ( # / 3) if # < 3 set # to 3.
        }
        eventsScroll.contentSize = CGSizeMake(contentWidth, contentHeight)
        var currentXOffset = CGFloat(0)
        var currentYOffset = CGFloat(0)
        let subviewEdge = CGFloat(150)
        print("SCROLL2 COUNT ATM : ")
        print(scroll2count)
        while (scroll2count > allocated) {
            print("INSIDE SCROLL COUNT WHILE LOOP")
            let frame = CGRectMake(currentXOffset, currentYOffset, 150, 150).insetBy(dx: 5, dy: 5)
            createTile(frame, title: "Events", content: eventInstance.z_Events[allocated], scroll: eventsScroll, imageStr: nil, specialData: nil)
            allocated++
            threecount = (threecount + 1) % 3
            if(threecount == 0){
                currentXOffset = CGFloat(0)
                currentYOffset += subviewEdge
            }else{
                currentXOffset += subviewEdge
            }
        }
    }
    
    
    func scrollViewPopulateStreams(){
        streamArray = TwitchData.sharedInstance.array
        let contentWidth = CGFloat(450)
        var contentHeight = CGFloat(200)
        let scroll3count = streamArray!.count /* Stream stuff *///eventInstance.z_Events.count
        var threecount = 0
        var allocated = 0
        if scroll3count > 3{
            contentHeight = CGFloat(165) * (CGFloat(scroll3count+1)/3) + CGFloat(10)//scrollView.bounds.height * 3 // change this based on # of items. CGFloat 150(tile) x ( # / 3) if # < 3 set # to 3.
        }
        streamScroll.contentSize = CGSizeMake(contentWidth, contentHeight)
        var currentXOffset = CGFloat(0)
        var currentYOffset = CGFloat(0)
        let subviewEdge = CGFloat(150)
        print("SCROLL3 COUNT ATM : ")
        print(scroll3count)
        while (scroll3count > allocated) {
            print("INSIDE SCROLL COUNT WHILE LOOP")
            let frame = CGRectMake(currentXOffset, currentYOffset, 150, 150).insetBy(dx: 5, dy: 5)
            createTile(frame, title: "Streams", content: "STREAM INFORMATION", scroll: streamScroll, imageStr: streamArray![allocated].zhi_previewString, specialData: streamArray![allocated])
            allocated++
            threecount = (threecount + 1) % 3
            if(threecount == 0){
                currentXOffset = CGFloat(0)
                currentYOffset += subviewEdge
            }else{
                currentXOffset += subviewEdge
            }
        }
    }
    
    
    func createTile(frame: CGRect, title: String, content: String, scroll: UIScrollView, imageStr: String?, specialData: AnyObject?){
        let tile = Tiles(frame: frame)
        tile.z_labelText = title
        tile.z_contentText = content
        if let imageStr = imageStr{
            tile.setTileContentImage(nil, imageStr: imageStr)
        }
        if let specialData = specialData{
            //atm the only special data is with twitchData. remove imageStr for special data mayhaps?
            tile.setSpecialData(specialData as! TwitchObject)
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedTile:")
        tile.userInteractionEnabled = true
        tapGestureRecognizer.numberOfTapsRequired = 2
        tile.addGestureRecognizer(tapGestureRecognizer)
        scroll.addSubview(tile)
    }
    
    
    func tappedTile(sender: UITapGestureRecognizer){
        print("Tile Tapped")
        let tile = sender.view as! Tiles
        let x = tile.frame.minX//sender.view?.frame.minX
        let y = tile.frame.minY//sender.view?.frame.minY
        let popWidth = CGFloat(400)
        let popHeight = CGFloat(400)
        let frame = CGRectMake(x, y, popWidth, popHeight)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("popvc") as! PopViewController
        vc.modalPresentationStyle = .Popover
        let popoverMenuViewController = vc.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.newsScroll
        popoverMenuViewController?.sourceRect = frame //(sender.view?.frame)!//CGRectMake(400, 300, 200, 200)
        self.presentViewController(vc, animated: true, completion: nil)
        vc.contentText.text = tile.z_contentText
        vc.titleLabel.text = tile.z_labelText
        vc.contentImage.image = tile.zh_content.image
        if tile.zh_title.text == "Streams"{
            vc.setStreamSegue()
            vc.popTwitchObject = tile.zh_twitchObject
        }
    }
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
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
            //self.tableView.reloadData()
            self.scrollViewPopulateNews()

        }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
        })
        scrollViewPopulateEvents()
        scrollViewPopulateStreams()
    }
    /*
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
    }*/

    

}
