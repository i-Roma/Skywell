//
//  TestProjectTextField.swift
//  TestProject
//
//  Created by Roma Balboa on 18.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class TestProjectTextField: UITextField {

//MARK: - Inset of Text Field
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
//MARK: - Editing Inset of Text Field
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
}
