//
//  TestProjectNavigationControllerViewController.swift
//  TestProject
//
//  Created by Roma Balboa on 17.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class TestProjectNavigationControllerViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ViewConstructor.customizeNavigationBar(to: self)
    }

//MARK: - Set White Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//MARK: - Hidden Status Bar
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
