//
//  TwitterClient.swift
//  twitter
//
//  Created by Karen Levy on 5/20/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

let twitterConsumerKey = "Bkel768VttvcraiTY6xZm6TW8"
let twitterConsumerSecret = "XbyePsl7pMLBr3VDToZJ3X3cbWLtE0Q3hebfK9FOZ4gzf2eHnp"
let twitterBaseURL =  NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?)->())?
    
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion:(tweets: [Tweet]?, error: NSError?) ->()){
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                         //   println("home timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)

            for tweet in tweets{
                println("text: \(tweet.text!), created: \(tweet.createdAt), username: \(tweet.user?.screenname)")
            }
            
        }, failure: {(operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed getting home timeline \(error)")
            completion(tweets: nil, error: error)
            
        })
    }
    
    func mentionsTimelineWithParams(params: NSDictionary?, completion:(mentions: [Mention]?, error: NSError?) ->()){
        
        GET("1.1/statuses/mentions_timeline.json", parameters: params, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
               println("mentions timeline: \(response)")
            //var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            var mentions = Mention.mentionsWithArray(response as! [NSDictionary])
            completion(mentions: mentions, error: nil)

            for mention in mentions{
                println("text: \(mention.text), username: \(mention.userName)")

            }
            
            }, failure: {(operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed getting home timeline \(error)")
                completion(mentions: nil, error: error)
                
        })
    }
    
    
    func retweetWithParams(params: NSDictionary?, completion:(tweets: [Tweet]?, error: NSError?) ->()){
        println("params: \(params!)")
        let value = params!["id"] as? NSNumber
        println("value: \(value!)")
        POST("1.1/statuses/retweet/\(value!).json", parameters: params!, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        println("finished retweeting?")
            
         }, failure: {(operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed retweeting \(error)")
                
        })
    }
    
    func favoriteWithParams(params: NSDictionary?, completion:(tweets: [Tweet]?, error: NSError?) ->()){
        println("params: \(params!)")
        let value = params!["id"] as? NSNumber
        println("value: \(value!)")
        POST("1.1/favorites/create.json", parameters: params!, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("finished favoriting?")
            
            }, failure: {(operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed favoriting \(error)")
                
        })
    }
    
    func composeTweetWithParams(params: NSDictionary?, completion:(tweets: [Tweet]?, error: NSError?) ->()){
        println("params: \(params!)")
        let value = params!["id"] as? NSNumber
        println("value: \(value!)")
        POST("1.1/statuses/update.json", parameters: params!, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("finished favoriting?")
            
            }, failure: {(operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed favoriting \(error)")
                
        })
    }

    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        // sometimes tokens are cached, so clear it first
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        // get request token
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            println("Got the token")
            
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }){(error: NSError!) -> Void in
                println("failed to get request token \(error)")
                self.loginCompletion?(user:nil, error: error)
        }

    }
    
    func openURL(url:NSURL){
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accesstoken: BDBOAuth1Credential!) -> Void in
            println("Got the access token! ")
            // This will use the access token to form all the requests
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accesstoken!)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user // persist the user
                println("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                
                }, failure: {(operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("failed getting current user \(error)")
                    self.loginCompletion?(user:nil, error: error)
            })
            
        }){(error: NSError!) -> Void in
            println("failed \(error)")
            self.loginCompletion?(user:nil, error: error)
        }

    }
   
}
