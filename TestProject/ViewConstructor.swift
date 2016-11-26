//
//  ViewConstructor.swift
//  TestProject
//
//  Created by Roma Balboa on 16.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

public class ViewConstructor {
    
    class func customizeNavigationBar(to navBar: UINavigationController) {
        navBar.navigationBar.barTintColor = Colors.projectGreen
        navBar.navigationBar.topItem?.title = "LOGO"
        navBar.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Futura-Bold", size: 34)!, NSForegroundColorAttributeName: UIColor.white]
    }
    
    class func add(nib nibName: String!, toView view: UIView!) {
        let nibArray = Bundle.main.loadNibNamed(nibName, owner: view, options: nil)
        let nibView = nibArray?.first as! UIView
        view.addSubview(nibView)
        ViewConstructor.add(constraintsToSuperview: view, fromSubview: nibView)
    }
    
    class func add(constraintsToSuperview superview : UIView!, fromSubview subview: UIView!) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    }
    
    class func add(shadowTo button: UIButton) {
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    class func addBorderToButton(button: UIButton, width: CGFloat, color: CGColor) {
        button.layer.borderWidth = width
        button.layer.borderColor = color
    }
}
