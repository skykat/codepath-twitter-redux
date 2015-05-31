//
//  MenuPanelViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/30/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

@objc
protocol MenuPanelViewControllerDelegate {
    func menuItemSelected(menuItem: MenuItem)
}

class MenuPanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    var delegate: MenuPanelViewControllerDelegate?
    var menuItems: Array<MenuItem>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
//        let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MenuCell, forIndexPath: indexPath) as? MenuCell
        cell.titleLabel.text = menuItems[indexPath.row].title
        println("title: \(menuItems[indexPath.row].title)")
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
