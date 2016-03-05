//
//  ProfileViewController.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/2/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit
import Parse

let userDidLogoutNotification = "userDidLogoutNotification"
let userDidLoginNotification = "userDidLoginNotification"


class ProfileViewController: UIViewController {
    
    let userDidLogoutNotification = "userDidLogoutNotification"


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOut()
         NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)

        
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
