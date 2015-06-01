//
//  Mentions.swift
//  twitter
//
//  Created by Karen Levy on 5/31/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class Mention: NSObject {
    var text: String?
    var userName: String?
    
    init(dictionary: NSDictionary){
        userName = dictionary["name"] as? String
        text = dictionary["text"] as? String
    }
    
    class func mentionsWithArray(array: [NSDictionary]) -> [Mention]{
        var mentions = [Mention]()
        
        for dictionary in array{
            // create a new tweet based on this new dictionary
            mentions.append(Mention(dictionary: dictionary))
        }
        
        return mentions;
    }


}

