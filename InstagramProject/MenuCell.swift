//
//  MenuCell.swift
//  InstagramProject
//
//  Created by YouGotToFindWhatYouLove on 3/1/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    
    @IBOutlet weak var menuIconImageView: UIImageView!
    
    @IBOutlet weak var menuItemNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
