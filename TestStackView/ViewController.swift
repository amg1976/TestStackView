//
//  ViewController.swift
//  TestStackView
//
//  Created by Adriano Goncalves on 16/06/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func touchedClearButton(sender: UIButton) {
        if let allFields = getAllTextFields() {
            _ = allFields.map {
                $0.text = nil
                $0.resignFirstResponder()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ZDSInputManager.shared.setup(withSourceViewController: self)
    }
    
}

extension ViewController : ZDSInputControllerDelegate {

    func didSelectMenuControllerItem(menuItem: UIMenuItem) {
        ZDSInputMainViewController.show()
    }
    
}
