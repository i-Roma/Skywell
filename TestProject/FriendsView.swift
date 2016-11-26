//
//  FriendsView.swift
//  TestProject
//
//  Created by Roma Balboa on 17.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class FriendsView: UIView {

    @IBOutlet var friendsTableView: UITableView!
    
    let cellIdentifier = "\(type(of: LoginWithFacebookTableViewCell()))"
    
    var dataToFriendsView: [String]? {
        didSet {
            guard dataToFriendsView?.count != 0 else {
                return
            }
            friendsTableView?.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let identifier = "\(type(of: self))"
        ViewConstructor.add(nib: identifier, toView: self)
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        friendsTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func configure(friendCell: LoginWithFacebookTableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        friendCell.fullnameFriend.text = "T" //dataToFriendsView?[indexPath.row]
        friendCell.fullnameFriend.text = dataToFriendsView?[0]
        
        if (self.dataToFriendsView?[1]) != nil {
        let url = URL(string: (dataToFriendsView?[1])!)
        
        DispatchQueue.global().async {
                let userPhoto = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    friendCell.picture.contentMode = .scaleAspectFill
                    friendCell.picture.image = UIImage(data: userPhoto!)
                }
        }
        } else {
            friendCell.picture.image = #imageLiteral(resourceName: "userNoPhoto")
        }
        
        return friendCell
    }
}

//MARK: - UITableViewDataSource

extension FriendsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LoginWithFacebookTableViewCell
        
        return self.configure(friendCell: cell, for: indexPath)
    }
    
}

extension FriendsView: UITableViewDelegate{
    
    @objc(tableView: heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
  
}
