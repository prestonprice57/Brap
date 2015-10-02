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
class SoundSelector: UITableViewController {
    
    var data = ["4-Stroke", "2-Stroke"]
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        print(cell.textLabel?.text)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(data[indexPath.row])
        itemSelected = data[indexPath.row]
        self.revealViewController().revealToggleAnimated(true)
    }
    
}