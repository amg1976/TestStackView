//
//  ZDSInputManager.swift
//  TestStackView
//
//  Created by Adriano Goncalves on 16/06/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func getAllTextFields(views: [UIView]? = nil) -> [UITextField]? {
        
        var result: [UITextField]?
        
        var currentViews: [UIView]
        if let views = views {
            currentViews = views
        } else {
            currentViews = view.subviews
        }
        
        for view in currentViews {
            if let view = view as? UITextField {
                if result == nil {
                    result = [UITextField]()
                }
                result?.append(view)
            }
        }
        
        for view in currentViews {
            if view.subviews.count > 0 {
                if let fields = getAllTextFields(view.subviews) {
                    if result == nil {
                        result = [UITextField]()
                    }
                    result?.appendContentsOf(fields)
                }
            }
        }
        
        return result
        
    }
    
    func getActiveTextField(views: [UIView]? = nil) -> UITextField? {
        return getAllTextFields()?.filter({ $0.isFirstResponder() }).first
    }
    
}


class ZDSInputManager: NSObject {
    
    static let shared = ZDSInputManager()
    
    private var items: [String:[String]] = [:]
    
    private (set) var currentViewController: UIViewController? {
        didSet {
            if let viewController = currentViewController,
                allFields = viewController.getAllTextFields() {
                
                _ = allFields.map {
                    $0.addTarget(self, action: #selector(textFieldValueChanged(_:)), forControlEvents: .EditingDidEnd)
                }
                
            }
            
        }
    }
    
    internal var sourceTextField: UITextField?
    
    override init() {
        super.init()
        items = [ "Some text" : [], "More text" : [], "Even more text" : [] ]
    }
    
    func setup(withSourceViewController viewController: UIViewController) {
        
        let menuItem = UIMenuItem(title: "ZDSInput...", action: #selector(ZDSInputControllerDelegate.didSelectMenuControllerItem(_:)))
        
        var menuItems = [menuItem]
        if let existingItems = UIMenuController.sharedMenuController().menuItems {
            menuItems.insertContentsOf(existingItems, at: 0)
        } else {
            UIMenuController.sharedMenuController().menuItems = [menuItem]
        }
        UIMenuController.sharedMenuController().update()
        
        currentViewController = viewController
        
    }
    
    func textFieldValueChanged(textField: UITextField) {
        guard let text = textField.text where !text.isEmpty else { return }
        
        let fieldIdentifier = textField.accessibilityIdentifier ?? ""
        if !items.keys.contains(text) {
            items[text] = [fieldIdentifier]
        } else {
            items[text]?.append(fieldIdentifier)
        }
    }
    
    func autofill() {
        
        guard let allFields = currentViewController?.getAllTextFields() else { return }
        
        for field in allFields.filter({ $0.accessibilityIdentifier != nil }) {
            for (key, _) in items.filter({ $0.1.contains(field.accessibilityIdentifier!) }) {
                field.text = key
                break
            }
            
            if field.text == nil || field.text!.isEmpty {
                let keys = Array(items.keys)
                let idx = arc4random_uniform(UInt32(keys.count))
                field.text = keys[Int(idx)]
            }
        }
    }
    
}

extension ZDSInputManager: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        let keys = Array(items.keys).sort()
        cell.textLabel?.text = keys[indexPath.row]
        return cell
    }
    
}