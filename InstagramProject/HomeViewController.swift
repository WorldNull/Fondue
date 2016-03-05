//
//  HomeViewController.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/3/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit
import Parse

let leftSwipe = "leftSwipe"
let rightSwipe = "rightSwipe"

class HomeViewController: UIViewController {
    
    var menuToggleOn: Bool!
    var menuButton: UIButton!
    var posts: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let menuFrame = CGRect(x: 8, y: 0, width: 40, height: (self.navigationController!.navigationBar.frame.height))
            
        menuButton = UIButton(frame: menuFrame)
        print("HamburgerOff")
        menuButton.setImage(UIImage(named: "HamburgerOff"), forState: .Normal)
            
        menuButton.addTarget(self, action: "onSlideMenuButtonPressed", forControlEvents: .TouchUpInside)
            
        self.navigationController!.navigationBar.addSubview(menuButton)
        
        menuToggleOn = false
        
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        

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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCell
        let postSection = posts![indexPath.section]
        let imageFile = postSection["media"] as! PFFile
        
        imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    cell.postImageView.image = UIImage(data: imageData)
                }
            }
        }
        cell.captionLabel.text = postSection["caption"] as! String

        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    /*
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/*320*/, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        headerView.addSubview(profileView)
        //let userSection = media[section]
        //let user = userSection["user"]
        //let profileUrl = NSURL(string: user!["profile_picture"] as! String)
        //profileView.setImageWithURL(profileUrl!)
        
        //let userName = user!["username"] as! String
        let nameView = UILabel(frame: CGRect(x: 48, y: 15, width: 250, height: 20))
        nameView.textColor = UIColor(red: 0, green: 98/255, blue: 193/255, alpha: 1)
        nameView.font = UIFont.boldSystemFontOfSize(14.0)
        nameView.text = "Testing"
        headerView.addSubview(nameView)
        
        
//        let creationTimeView = UILabel(frame: CGRect(x: , y: 15, width: 200, height: 20))
//        creationTimeView.font = UIFont.boldSystemFontOfSize(13.0)
//        creationTimeView.text = "01/02/2015"
//        headerView.addSubview(creationTimeView)

        
        
        
        return headerView

    }
    */
    
    
    
    
    
}


