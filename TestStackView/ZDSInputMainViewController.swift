//
//  ZDSInputMainViewController.swift
//  TestStackView
//
//  Created by Adriano Goncalves on 16/06/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

@objc
protocol ZDSInputControllerDelegate {
    
    func didSelectMenuControllerItem(menuItem: UIMenuItem)
    
}

class ZDSInputMainViewController: UITabBarController {

    @IBAction func didTouchCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didTouchAutofill(sender: AnyObject) {
        ZDSInputManager.shared.autofill()
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
