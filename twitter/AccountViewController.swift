//
//  AccountViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/31/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var numberTweetsLabel: UILabel!

    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = User.currentUser?.name
        userNameLabel.text = User.currentUser?.screenname
        tagLineLabel.text = User.currentUser?.tagline
        profileImageView.setImageWithURL(User.currentUser?.profileImageUrl)
        headerImageView.setImageWithURL(User.currentUser?.profileBannerUrl)
        followingLabel.text = "following \(User.currentUser?.numberFollowing!)"
        followersLabel.text = "followers \(User.currentUser?.numberOfFollowers!)"
        numberTweetsLabel.text = "tweets \(User.currentUser?.numberOfTweets!)"
        
        
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
