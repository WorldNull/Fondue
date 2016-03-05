//
//  InstagramCell.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/5/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class InstagramCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
        
    @IBOutlet weak var captionLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
