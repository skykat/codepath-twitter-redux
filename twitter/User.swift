//
//  User.swift
//  twitter
//
//  Created by Karen Levy on 5/23/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit


var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotificiation = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: NSURL?
    var tagline: String?
    var profileBannerUrl: NSURL?
    var numberOfFollowers: NSNumber?
    var numberFollowing: NSNumber?
    var numberOfTweets: NSNumber?
    var dictionary: NSDictionary
    
    // create dictionary and deserialize them into each one
    init(dictionary: NSDictionary){

        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let imageURLString = dictionary["profile_image_url"] as? String
        if imageURLString != nil {
            profileImageUrl = NSURL(string: imageURLString!)!
        } else {
            profileImageUrl = nil
        }
        tagline = dictionary["description"] as? String
        let bannerURLString = dictionary["profile_banner_url"] as? String
        if bannerURLString != nil {
            profileBannerUrl =  NSURL(string: bannerURLString!)!
        } else {
            profileBannerUrl = nil
        }
    
        
        numberOfFollowers = dictionary["followers_count"] as? NSNumber
        numberFollowing = dictionary["friends_count"] as? NSNumber
        numberOfTweets = dictionary["statuses_count"] as? NSNumber
        
//        "favourites_count" = 8;
//        "follow_request_sent" = 0;
//        "followers_count" = 61;
//        following = 0;
//        "friends_count" = 174;
//        "geo_enabled" = 0;
//        id = 66938695;
//        "id_str" = 66938695;
//        "is_translation_enabled" = 0;
//        "is_translator" = 0;
//        lang = en;
//        "listed_count" = 9;
//        location = "San Francisco";
        
        println(" user details: \(dictionary)")
    }
    
    func logout(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotificiation, object: nil)
        
    }
    
    class var currentUser: User?{
        get{
            if _currentUser == nil{
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil{
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user){
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else{
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
