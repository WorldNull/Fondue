//
//  MenuHeaderCell.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/4/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class MenuHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
