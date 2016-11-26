//
//  LoginWithFacebookViewController.swift
//  TestProject
//
//  Created by Roma Balboa on 16.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class LoginWithFacebookViewController: UIViewController {

    @IBOutlet var facebookFieldsView: FacebookFieldsView!
    @IBOutlet var friendsView: FriendsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginWithFacebookViewController.catchFacebookFieldsViewNotification(notification:)), name: Constants.dataToFacebookFieldsView, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginWithFacebookViewController.catchFriendsViewNotification(notification:)), name: Constants.dataToFriendsView, object: nil)
    }

    func catchFacebookFieldsViewNotification(notification: NSNotification) {
        let response = notification.object
        print("response: ", response ?? "default value")
        facebookFieldsView.dataToFacebookFieldsView = response as! [String]?
    }
    
    func catchFriendsViewNotification(notification: NSNotification) {
        let response = notification.object
        print("response: ", response ?? "default value")
        friendsView.dataToFriendsView = response as! [String]?
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Unsubscribe from observer
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
