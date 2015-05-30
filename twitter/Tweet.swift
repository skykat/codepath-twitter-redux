//
//  Tweet.swift
//  twitter
//
//  Created by Karen Levy on 5/23/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweeted: String?
    var retweetCount: String?
    var favoriteCount: String?
    var tweetId: NSNumber?
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        if text!.hasPrefix("RT"){
            var retweetUserName = text!.componentsSeparatedByString(":")
            retweeted = retweetUserName[0]
        }
        tweetId = dictionary["id"] as? NSNumber
        retweetCount = dictionary["retweet_count"] as? String
        favoriteCount = dictionary["favorite_count"] as? String

        
        
    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
    
        for dictionary in array{
            // create a new tweet based on this new dictionary
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets;
    }
}
