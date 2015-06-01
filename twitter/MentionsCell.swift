//
//  MentionsCell.swift
//  twitter
//
//  Created by Karen Levy on 5/31/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class MentionsCell: UITableViewCell {
    @IBOutlet weak var mentionsLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var mention: Mention! {
        didSet{
            mentionsLabel.text = mention.text
            userNameLabel.text = mention.userName
            //userNameLabel.text = "@\(tweet.user?.screenname!)"

            
        }
    }

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
