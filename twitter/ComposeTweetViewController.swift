//
//  ComposeTweetViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/25/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var composeTextView: UITextView!
     var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text =  User.currentUser?.name
        userNameLabel.text =  User.currentUser?.screenname
        profileImageView.setImageWithURL( User.currentUser?.profileImageUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTweet(sender: UIBarButtonItem) {
        println("onTweet")
        var tweetIdDictionary = [String: String]()
        var tweetText: String = tweetTextView.text!
        
        tweetIdDictionary["status"] = tweetText
        TwitterClient.sharedInstance.composeTweetWithParams(tweetIdDictionary, completion: {(tweets, error) -> () in
            println("Finished favoriting...")
            
        })
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
