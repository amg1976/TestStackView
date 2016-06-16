//
//  ZDSInputRecentsTableViewController.swift
//  TestStackView
//
//  Created by Adriano Goncalves on 16/06/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class ZDSInputRecentsTableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
}

extension ZDSInputRecentsTableViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)

        cell.textLabel?.text = "Some text"

        return cell
    }

}

extension ZDSInputRecentsTableViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let parent = self.parentViewController as? ZDSInputMainViewController,
            text = cell?.textLabel?.text {
            parent.updateSourceController(text)
        }
        
    }
    
}
