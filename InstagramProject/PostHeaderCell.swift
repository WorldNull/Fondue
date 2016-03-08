//
//  PostHeaderCell.swift
//  InstagramProject
//
//  Created by YouGotToFindWhatYouLove on 3/7/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    var profileImage: UIImage!
    
    var profileName: String!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var postCreatedAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.image = profileImage
        profileNameLabel.text = profileName
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}