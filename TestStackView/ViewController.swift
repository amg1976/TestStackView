//
//  ViewController.swift
//  TestStackView
//
//  Created by Adriano Goncalves on 16/06/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ZenInputController.shared.setup(withSourceViewController: self)
    }
    
}

extension ViewController : ZenInputControllerDelegate {

    func didSelectMenuControllerItem(menuItem: UIMenuItem) {
        ZenInputMainViewController.show()
    }
    
}
