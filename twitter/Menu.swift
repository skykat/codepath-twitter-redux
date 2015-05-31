//
//  Menu.swift
//  twitter
//
//  Created by Karen Levy on 5/31/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class Menu {
    
    let title: String
    let image: UIImage?
    
    
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    class func items() -> Array<Menu> {
        return [ Menu(title: "Profile", image: UIImage(named: "ID-100113060.jpg")),
            Menu(title: "Timeline", image: UIImage(named: "ID-10022760.jpg")),
            Menu(title: "Mentions", image: UIImage(named: "ID-10011404.jpg")) ]
    }


}
