//
//  SoundSelector.swift
//  Brap
//
//  Created by Preston Price on 10/1/15.
//  Copyright © 2015 BendyStraw. All rights reserved.
//

import Foundation
import UIKit

var itemSelected = "4-Stroke"
var data = ["4-Stroke", "2-Stroke", "Record new brap"]

class SoundSelector: UITableViewController {
    
    // Reload the table when view appears to see if there are any new recordings
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont(name: "GillSans-Light", size: 16)!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if data[indexPath.row] == "Record new brap" {
            performSegueWithIdentifier("record", sender: self)
        } else {
            itemSelected = data[indexPath.row]
        }
        self.revealViewController().revealToggleAnimated(true)
    }
    
}