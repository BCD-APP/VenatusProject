//
//  GamePopViewController.swift
//  Venatus
//
//  Created by Douglas on 4/25/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

protocol GamePopViewControllerDelegate : class{
    func selectedItem(name: String?)
}


class GamePopViewController: UIViewController {

    @IBOutlet var addGameButton: UIButton!
    @IBOutlet var lbutton: UIButton!
    @IBOutlet var rbutton: UIButton!
    
    
    var NumberCounter: Int = 0
    let games: Array<String> = GamesList.names()
    
    
    @IBOutlet var scrollView: UIScrollView!
    weak var delegate: GamePopViewControllerDelegate!
    
    var selection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentWidth = (CGFloat(50) * (CGFloat(games.count)))
        let contentHeight = scrollView.bounds.height
        scrollView.contentSize = CGSizeMake(contentWidth, contentHeight)
        
        let subviewWidth = CGFloat(50)
        var currentViewOffset = CGFloat(0);
        
        while currentViewOffset < contentWidth {
            let frame = CGRectMake(currentViewOffset, 0, subviewWidth, 50).insetBy(dx: 5, dy: 5)
            if(NumberCounter < games.count){
                let button = UIButton(type: UIButtonType.Custom)
                button.addTarget(self, action: "imageClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                button.setTitle(games[NumberCounter], forState: UIControlState.Normal)
                button.frame = frame
                button.setImage(UIImage(named: games[NumberCounter]), forState: .Normal)
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.clearColor().CGColor
                scrollView.addSubview(button)
            }
            currentViewOffset += subviewWidth
            NumberCounter++
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rightButtonClicked(sender: UIButton) {
        print("Right")
        var newX = scrollView.contentOffset.x + 50
        //End of the scroll to the right
        if (newX > CGFloat(scrollView.contentSize.width-scrollView.frame.size.width)){
            newX = scrollView.contentSize.width-scrollView.frame.size.width
        }
        let newOffset = CGPointMake(newX, scrollView.contentOffset.y)
        scrollView.setContentOffset(newOffset, animated: true)
    }
    
    
    @IBAction func leftButtonClicked(sender: UIButton) {
        print("LEFT")
        var newX = scrollView.contentOffset.x - 50
        if(newX < 0){
            newX = CGFloat(0)
        }
        let newOffset = CGPointMake(newX, scrollView.contentOffset.y)
        scrollView.setContentOffset(newOffset, animated: true)
    }
    
    func imageClicked(sender: UIButton){
        selection = sender.titleLabel?.text
        print("Game le clicked by \(sender.titleLabel?.text)")
        if CGColorEqualToColor(sender.layer.borderColor, UIColor.redColor().CGColor){
            sender.layer.borderColor = UIColor.clearColor().CGColor
        }else{
            sender.layer.borderColor = UIColor.redColor().CGColor
        }
    }
    @IBAction func addGameButton(sender: UIButton) {
        print("Clicked Add Button")
        if let selection = selection{
            delegate.selectedItem(selection)
        }else{
            print("Nothing selected")
        }
    }
    
}
