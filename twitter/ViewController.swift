//
//  ViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/20/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil{
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{
                // handle login error
            }
        }
        
    }

}

