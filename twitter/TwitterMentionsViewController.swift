//
//  TwitterMentionsViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/31/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class TwitterMentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { 

    @IBOutlet weak var tableView: UITableView!
    
    var mentions: [Mention]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.mentionsTimelineWithParams(nil, completion: {(mentions, error) -> () in
            self.mentions = mentions
            self.tableView.reloadData()
            //self.tweets = tweets
            //self.tableView.reloadData()
            // tweet.favorite will do a post
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mentions != nil{
            return mentions!.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MentionsCell", forIndexPath: indexPath) as! MentionsCell
        cell.mention = self.mentions[indexPath.row]
        return cell
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
