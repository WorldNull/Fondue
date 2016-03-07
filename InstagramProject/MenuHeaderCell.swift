//
//  MenuHeaderCell.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/4/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit
import Parse

class MenuHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    var imageFile: PFFile!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true;
  
        setProfileImage()
        
    }
    
    func setProfileImage() {
        let currentUser = PFUser.currentUser()
        imageFile = currentUser!["ProfileImage"] as? PFFile
        profileNameLabel.text = currentUser?.username
        

        
        if let imageFile = imageFile {
            imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        self.profileImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

