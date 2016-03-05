//
//  HamburgerViewController.swift
//  Hamburger Menu Demo
//
//  Created by Timothy Lee on 9/18/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit


class HamburgerViewController: UIViewController {
    
    
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet(oldMenuViewController) {
            view.layoutIfNeeded()
            
            if oldMenuViewController != nil {
                oldMenuViewController.willMoveToParentViewController(nil)
                oldMenuViewController.view.removeFromSuperview()
                oldMenuViewController.didMoveToParentViewController(nil)
            }
            
            menuViewController.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height)
            menuView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height)
            menuView.addSubview(menuViewController.view)
            
            print(self.view.frame.size)
            print("menuView.frame.size: \(menuView.frame.size)")
            print("menuViewController.view.frame.size\(menuViewController.view.frame.size)")

        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMoveToParentViewController(nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMoveToParentViewController(nil)
            }
            
            
            contentViewController.willMoveToParentViewController(self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMoveToParentViewController(self)

            
            UIView.animateWithDuration(0.3) { () -> Void in
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onSwipeGestureLeft:", name: leftSwipe, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onSwipeGestureRight:", name: rightSwipe, object: nil)
        print("UIScreen.mainScreen().bounds.size: \(UIScreen.mainScreen().bounds.size)")
        print("menuView.bounds.size: \(menuView.bounds.size)")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSwipeGestureLeft(sender: UISwipeGestureRecognizer) {
        
        UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
            self.leftMarginConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (Bool) -> Void in
        }
        
    }
    
    @IBAction func onSwipeGestureRight(sender: UISwipeGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
            self.leftMarginConstraint.constant = self.view.frame.size.width / 2
            self.animateTable()
            self.view.layoutIfNeeded()
        
        }) { (Bool) -> Void in
        }
    }
    
    func animateTable() {
        let tableView = self.menuViewController.view.subviews[0] as! UITableView
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        
        for i in cells {
            let cell = i as! MenuCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as! MenuCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
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
