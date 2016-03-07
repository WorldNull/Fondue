//
//  MenuViewController.swift
//  Hamburger Menu Demo
//
//  Created by Timothy Lee on 9/18/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var homeNavigationController: UIViewController!
    private var captureNavigationController: UIViewController!
    private var profileNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var menuItemNameArray: [String]!

    
    var hamburgerViewController: HamburgerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        menuItemNameArray = ["Home", "Capture", "Profile"]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeNavigationController = storyboard.instantiateViewControllerWithIdentifier("HomeNavigationController")
        captureNavigationController = storyboard.instantiateViewControllerWithIdentifier("CaptureNavigationController")
        profileNavigationController = storyboard.instantiateViewControllerWithIdentifier("ProfileNavigationController")
        
        viewControllers.append(homeNavigationController)
        viewControllers.append(captureNavigationController)
        viewControllers.append(profileNavigationController)

        hamburgerViewController?.contentViewController = homeNavigationController
        
        hamburgerViewController?.contentViewController.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let topColor = UIColor(red: 203/255, green: 173/255, blue: 109/255, alpha: 0.5)
        let bottomColor = UIColor(red: 213/255, green: 51/255, blue: 105/255, alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = tableView.bounds
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, atIndex: 0)
        tableView.backgroundView = backgroundView

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        cell.menuIconImageView.image = UIImage(named: "\(menuItemNameArray[indexPath.row])")
        
        
        cell.menuItemNameLabel.text = "\(menuItemNameArray[indexPath.row])"
        
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        cell.backgroundColor = UIColor.clearColor()
    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        hamburgerViewController?.contentViewController = viewControllers[indexPath.row]
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! MenuHeaderCell
        
        return headerCell.contentView
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 181
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
