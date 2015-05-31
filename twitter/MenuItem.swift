//
//  MenuItem.swift
//  twitter
//
//  Created by Karen Levy on 5/30/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

@objc
class MenuItem {
    
    let title: String
    let image: UIImage?
    
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    class func allMenuItems() -> Array<MenuItem> {
        return [ MenuItem(title: "Profile", image: UIImage(named: "ID-100113060.jpg")),
            MenuItem(title: "Timeline", image: UIImage(named: "ID-10022760.jpg")),
            MenuItem(title: "Mentions", image: UIImage(named: "ID-10011404.jpg")) ]
    }

   
}
