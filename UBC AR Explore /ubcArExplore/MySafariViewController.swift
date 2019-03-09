//
//  MySafariViewController.swift
//  ubcArExplore
//
//  Created by Eric Lee on 2017-08-29.
//  Copyright © 2017 Erics App House. All rights reserved.
//

import UIKit
import SafariServices


/*
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------
 */

// MARK: Safari View Controller

class MySafariViewContoller: SFSafariViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            // enabling rotation
            delegate.blockRotation = true
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            // disabling rotation
            delegate.blockRotation = false
            
        }
        
    }
    
}
