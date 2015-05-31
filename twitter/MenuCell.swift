//
//  MenuCell.swift
//  twitter
//
//  Created by Karen Levy on 5/30/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func populateMenu(item: Menu) {
        titleLabel.text = item.title
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
