//
//  BaseViewController.swift
//  InstagramProject
//
//  Created by YouGotToFindWhatYouLove on 2/29/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    

    var menuButton: UIButton!

    var menuToggleOn: Bool!
    
    var menuNavController: UINavigationController!
    
    var menuNavControllerWidth: CGFloat!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        menuToggleOn = false
        
        initialState()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialState() {
        menuNavController = self.storyboard!.instantiateViewControllerWithIdentifier("ToMenuViewController") as!UINavigationController
        
        self.view.addSubview(menuNavController.view)
        self.addChildViewController(menuNavController)
        menuNavController.view.layoutIfNeeded()
        menuNavControllerWidth = self.view.frame.width / 2
        
        menuNavController.view.frame = CGRectMake(-menuNavControllerWidth, 0, menuNavControllerWidth, self.view.frame.height)
    }
    
    func addSlideMenuButton(){
    
        if let navigationBar = self.navigationController?.navigationBar {
            
            let menuFrame = CGRect(x: 8, y: 0, width: 40, height: navigationBar.frame.height)
            
            menuButton = UIButton(frame: menuFrame)
            print("HamburgerOff")
            menuButton.setImage(UIImage(named: "HamburgerOff"), forState: .Normal)
            
            menuButton.addTarget(self, action: "onSlideMenuButtonPressed:", forControlEvents: .TouchUpInside)
            
            navigationBar.addSubview(menuButton)
            
        }

    }
    
    func onSlideMenuButtonPressed(sender : UIButton) {
        
        if menuToggleOn == true {
            UIView.transitionWithView(menuButton, duration: 0.5,
                options: UIViewAnimationOptions.TransitionFlipFromLeft,
                animations: {
                    self.menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
                    self.menuButton.setImage(UIImage(named: "HamburgerOff"), forState:.Normal)
                }, completion: nil)
            
            // hide menuNavController
            leftSwipe()
        } else {
            UIView.transitionWithView(menuButton, duration: 0.5,
                options: UIViewAnimationOptions.TransitionFlipFromRight,
                animations: {
                    self.menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0)
                    self.menuButton.setImage(UIImage(named: "HamburgerOn"), forState:.Normal)
                }, completion: nil)
            
            // show menuNavController
            rightSwipe()
        }
    }
    
    func leftSwipe() {
          print("leftSwipe origin: \(menuNavController.view.frame.origin)")
        UIView.animateWithDuration(0.5, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                self.menuNavController.view.frame = CGRectOffset(self.menuNavController.view.frame, -self.menuNavControllerWidth, 0)
                self.menuToggleOn = false
            }, completion: { (Bool) -> Void in
            print("leftSwipe dest: \(self.menuNavController.view.frame.origin)")
            print("-------------------------------s")
        })
        
    }
    
    func rightSwipe(){
        print("rightSwipe origin: \(menuNavController.view.frame.origin)")
        UIView.animateWithDuration(0.5, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                self.menuNavController.view.frame = CGRectOffset(self.menuNavController.view.frame, +self.menuNavControllerWidth, 0)
                 print("rightSwipe dest: \(self.menuNavController.view.frame.origin)")
                self.menuToggleOn = true
            }, completion: { (Bool) -> Void in
        })
        
    }
    

        
    
}

