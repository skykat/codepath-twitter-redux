//
//  TweetDetailsViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/24/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetedUsernameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetDetails: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var tweetId: NSNumber?
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet.user?.name
        usernameLabel.text = tweet.user?.screenname
        tweetDetails.text = tweet.text
        timeLabel.text = tweet?.createdAtString
        profileImageView.setImageWithURL(tweet.user?.profileImageUrl)
        retweetedUsernameLabel.text = tweet.retweeted
        if retweetedUsernameLabel.text == nil
        {
            retweetImageView.hidden = true
        }else{
            retweetImageView.hidden = false
        }
        retweetCountLabel.text = tweet.retweetCount
        favoriteCountLabel.text = tweet.favoriteCount
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onReply(sender: AnyObject) {
    }

    @IBAction func onRetweet(sender: AnyObject) {
        var tweetIdDictionary = [String: NSNumber]()
        
        tweetId = tweet?.tweetId
        tweetIdDictionary["id"] = tweetId!
        
        println("tweetId: \(tweetId!)")
        TwitterClient.sharedInstance.retweetWithParams(tweetIdDictionary, completion: {(tweets, error) -> () in
            println("Finished retweeting...")
        })
        self.retweetButton.setImage(UIImage(named: "twitterretweet_on.png"), forState: UIControlState.Normal)

    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        
        var tweetIdDictionary = [String: NSNumber]()
        
        tweetId = tweet?.tweetId
        tweetIdDictionary["id"] = tweetId!
        
        println("tweetId: \(tweetId!)")
        TwitterClient.sharedInstance.favoriteWithParams(tweetIdDictionary, completion: {(tweets, error) -> () in
            println("Finished favoriting...")
        })
        
        self.favoriteButton.setImage(UIImage(named: "twitterfavoriteon.png"), forState: UIControlState.Normal)
        

    }
}
