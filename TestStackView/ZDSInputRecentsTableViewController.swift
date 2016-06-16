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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = ZDSInputManager.shared
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
