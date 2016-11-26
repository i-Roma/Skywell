//
//  TestProjectFacebookButton.swift
//  TestProject
//
//  Created by Roma Balboa on 16.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class TestProjectButton: UIButton {
    
    private struct TestProjectButton {
        static let width = CGFloat(1)
        static let textColor = Colors.projectGreen
        static let backroundColor = UIColor(red: 40/255, green: 47/255, blue: 57/255, alpha: 1)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = TestProjectButton.width
        self.backgroundColor = TestProjectButton.backroundColor
        self.tintColor = TestProjectButton.textColor
//        self.layer.borderColor = UIColor.blackColor().CGColor
    }

}
