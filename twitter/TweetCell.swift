//
//  TweetCell.swift
//  twitter
//
//  Created by Karen Levy on 5/24/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

protocol TweetCellDelegate {
    func tweetSelected(tweet: Tweet)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetImageView: UIImageView!

    var delegate: TweetCellDelegate?
    
    var tweetId: NSNumber?
    var tweet: Tweet! {
        didSet{
            nameLabel.text = tweet.user?.name
            //userNameLabel.text = "@\(tweet.user?.screenname!)"
            userNameLabel.text = tweet.user?.screenname
            tweetLabel.text = tweet?.text
            profileImageView.setImageWithURL(tweet.user?.profileImageUrl)
            retweetedLabel.text = tweet?.retweeted
            if retweetedLabel.text == nil
            {
                retweetImageView.hidden = true
            }else{
                retweetImageView.hidden = false
            }
            
            
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

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
