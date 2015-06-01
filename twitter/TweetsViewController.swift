//
//  TweetsViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/23/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {
   // var delegate: TweetsViewControllerDelegate?
    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchTweets", forControlEvents: UIControlEvents.ValueChanged)
        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = tableView
        dummyTableVC.refreshControl = refreshControl
        
        fetchTweets()
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            // tweet.favorite will do a post
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets!.count
        }else{
            return 0
        }
    }
    
    
    func tweetSelected(tweet: Tweet) {
        // This is not getting called for some reason
        println("tweet: \(tweet.text)")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
    
    func fetchTweets() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            // tweet.favorite will do a post
        })
    }
    
    @IBAction func onSignout(sender: AnyObject) {
                User.currentUser?.logout()
    }

  
  


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "com.codepath.tweetmodal"{
            println("com.codepath.tweetmodal")

        }else if segue.identifier == "com.codepath.profileimage"{
            let userProfileViewController = segue.destinationViewController as? UserProfileViewController
    
            println("preparing for next page")
            
//            if segue.identifier == "com.codepath.profileimage" {
//                if let destination = segue.destinationViewController as? UserProfileViewController {
//                    if let index = tableView.indexPathForSelectedRow()?.row {
//                        destination.tweet = tweets[index]
//                                    println("index: \(index)")
//                    }
//                }
//            }

            
        }else{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = tweets![indexPath.row]
            let tweetDetailsViewController = segue.destinationViewController as! TweetDetailsViewController
            tweetDetailsViewController.tweet = tweet
            println("preparing for next page")
        }

    
    }

    
    @IBAction func onCancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func onTweet(segue:UIStoryboardSegue) {
        
    }
 
//    extension TweetDetailsViewController: TweetCellDelegate {
//        func tweetSelected(tweet: Tweet) {
////            let vc = item.viewController()
////            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleLeftPanel")
////            self.centerNavigationController.viewControllers = [vc]
////            self.collapseSidePanels()
//        }
//    }

    
}
