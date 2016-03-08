//
//  ProfilePageViewController.swift
//  InstagramProject
//
//  Created by YouGotToFindWhatYouLove on 3/6/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController {
    
    var profileImage: UIImage!
    var profileName: String!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let image = profileImage {
            profileImageView.image = image
        }
        
        if let profileName = profileName {
            profileNameLabel.text = profileName
        }
        
        print("original profileImage size: \(profileImageView.frame.size)")
        
        self.navigationController?.navigationBar.subviews[1].hidden = true
        
    }
    
    override func viewDidLayoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        
        
        profileImageView.layer.masksToBounds = true;
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 3.0;
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor

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
