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
   // var posts: [PFObject]?
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    var query: PFQuery!


    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        
        let menuFrame = CGRect(x: 8, y: 0, width: 40, height: (self.navigationController!.navigationBar.frame.height))
            
        menuButton = UIButton(frame: menuFrame)
        print("HamburgerOff")
        menuButton.setImage(UIImage(named: "HamburgerOff"), forState: .Normal)
            
        menuButton.addTarget(self, action: "onSlideMenuButtonPressed", forControlEvents: .TouchUpInside)
            
        self.navigationController!.navigationBar.addSubview(menuButton)
        
        menuToggleOn = false
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        
        // construct PFQuery
        query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                SharingPosts.sharedInstance.posts = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        self.navigationController?.navigationBar.subviews[1].hidden = false
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, var sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ToProfilePage" {
            if ((sender as? UIImageView) != nil) {
                sender = sender as? UIImageView
            } else {
                sender = sender as? UILabel
                
            }
            let postHeaderCell = sender?.superview as? PostHeaderCell
            
            let vc = segue.destinationViewController as! ProfilePageViewController
            vc.profileImage = postHeaderCell?.profileImageView.image
            vc.profileName = postHeaderCell?.profileNameLabel.text
            
        }
        
    }
    

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCell
        let postSection = SharingPosts.sharedInstance.posts![indexPath.section]
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
        if let posts = SharingPosts.sharedInstance.posts {
            return posts.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("PostHeaderCell") as! PostHeaderCell
        headerCell.profileImageView.userInteractionEnabled = true
        headerCell.profileNameLabel.userInteractionEnabled = true
        
        let postSection = SharingPosts.sharedInstance.posts![section]
        
        let currentUser = postSection["author"] as! PFUser
        let imageFile = currentUser["ProfileImage"] as? PFFile
        
        if let imageFile = imageFile {
            imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        headerCell.profileImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        headerCell.profileNameLabel.text = currentUser.username
        
        
        let date = postSection.createdAt
        var dateFormatter = NSDateFormatter()
        
        //format style. Browse online to get a format that fits your needs.
        dateFormatter.dateFormat = "hh:mm MM/dd/YY"
        var dateString = dateFormatter.stringFromDate(date!)
        headerCell.postCreatedAtLabel.text = dateString

    
        return headerCell
      
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.15 * UIScreen.mainScreen().bounds.size.width
    }
    
    

}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // ... Code to load more results ...
                if let posts = SharingPosts.sharedInstance.posts {
                    // construct PFQuery
                    query.orderByDescending("createdAt")
                    query.includeKey("author")
                    query.limit = query.limit + 20
                    
                    query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
                        if let posts = posts {
                            SharingPosts.sharedInstance.posts = posts
                            // Update flag
                            self.isMoreDataLoading = false
                            
                            // Stop the loading indicator
                            self.loadingMoreView!.stopAnimating()
                            
                            self.tableView.reloadData()
                            
                        } else {
                            print(error?.localizedDescription)
                        }
                    }
                    
                } else {
                    self.loadingMoreView!.stopAnimating()
                }
            }
        }
    }
}


