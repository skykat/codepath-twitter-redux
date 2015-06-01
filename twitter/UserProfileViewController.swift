//
//  UserProfileViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/31/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("tweet: \(tweet!.text!)");
        let followers = tweet!.user!.numberFollowing!
        nameLabel.text = tweet?.user?.name
        userNameLabel.text = tweet?.user?.screenname
        taglineLabel.text = tweet?.user?.tagline
        profileImageView.setImageWithURL(tweet?.user?.profileImageUrl)
        bannerImageView.setImageWithURL(tweet?.user?.profileBannerUrl)
        followingLabel.text = "following \(followers)"
//        followersLabel.text = "followers \(tweet?.user?.numberOfFollowers!)"
//        tweetsLabel.text = "tweets \(tweet?.user?.numberOfTweets!)"
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

}
