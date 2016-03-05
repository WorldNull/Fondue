//
//  HomeViewController.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/3/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

let leftSwipe = "leftSwipe"
let rightSwipe = "rightSwipe"

class HomeViewController: UIViewController {
    
    var menuToggleOn: Bool!
    var menuButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuFrame = CGRect(x: 8, y: 0, width: 40, height: (self.navigationController!.navigationBar.frame.height))
            
        menuButton = UIButton(frame: menuFrame)
        print("HamburgerOff")
        menuButton.setImage(UIImage(named: "HamburgerOff"), forState: .Normal)
            
        menuButton.addTarget(self, action: "onSlideMenuButtonPressed", forControlEvents: .TouchUpInside)
            
        self.navigationController!.navigationBar.addSubview(menuButton)
        
        menuToggleOn = false
        

    }
    
    func onSlideMenuButtonPressed() {
        
        if menuToggleOn == true {
            UIView.transitionWithView(menuButton, duration: 0.5,
                options: UIViewAnimationOptions.TransitionFlipFromLeft,
                animations: {
                    self.menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
                    self.menuButton.setImage(UIImage(named: "HamburgerOff"), forState:.Normal)
                }, completion: nil)
            NSNotificationCenter.defaultCenter().postNotificationName(leftSwipe, object: nil)
            self.menuToggleOn = false

        } else {
            UIView.transitionWithView(menuButton, duration: 0.5,
                options: UIViewAnimationOptions.TransitionFlipFromRight,
                animations: {
                    self.menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0)
                    self.menuButton.setImage(UIImage(named: "HamburgerOn"), forState:.Normal)
                }, completion: nil)
            
            NSNotificationCenter.defaultCenter().postNotificationName(rightSwipe, object: nil)
            self.menuToggleOn = true
        }
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

}
