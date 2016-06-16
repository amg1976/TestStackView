//
//  ZDSInputMainViewController.swift
//  TestStackView
//
//  Created by Adriano Goncalves on 16/06/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

extension UIViewController {

    private func getAllTextFields(views: [UIView]? = nil) -> [UITextField]? {
    
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
    
    private func getActiveTextField(views: [UIView]? = nil) -> UITextField? {
        return getAllTextFields()?.filter({ $0.isFirstResponder() }).first
    }
    
}

class ZDSInputManager: NSObject {
    
    static let shared = ZDSInputManager()
    
    private var currentFields: [UITextField]?

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
    
    func setup(withSourceViewController viewController: UIViewController) {
        
        let menuItem = UIMenuItem(title: "ZenInput...", action: #selector(ZDSInputControllerDelegate.didSelectMenuControllerItem(_:)))
        
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
        print(textField.text)
    }
    
}

@objc
protocol ZDSInputControllerDelegate {
    
    func didSelectMenuControllerItem(menuItem: UIMenuItem)
    
}

class ZDSInputMainViewController: UITabBarController {

    @IBAction func didTouchCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    static func show() {
        
        if let mainViewController = UIStoryboard(name: "ZenInput", bundle: nil).instantiateInitialViewController() as? UINavigationController,
            viewController = ZDSInputManager.shared.currentViewController,
            textField = viewController.getActiveTextField() {
            
                ZDSInputManager.shared.sourceTextField = textField
                viewController.presentViewController(mainViewController, animated: true, completion: nil)
                
        }
        
    }
    
    func updateSourceController(text: String) {
        ZDSInputManager.shared.sourceTextField?.text = text
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
