//
//  FacebookFieldsView.swift
//  TestProject
//
//  Created by Roma Balboa on 18.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class FacebookFieldsView: UIView {
    
    @IBOutlet var facebookFieldsTableView: UITableView!
    
    let cellIdentifier = "\(type(of: ReuseableTableViewCell()))"
    let labelValue = ["Email", "Name", "Date of birth"]
    
    var dataToFacebookFieldsView: [String]? {
        didSet {
            guard dataToFacebookFieldsView?.count != 0 else {
                return
            }
            facebookFieldsTableView?.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let identifier = "\(type(of: self))"
        ViewConstructor.add(nib: identifier, toView: self)
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        facebookFieldsTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func configure(facebookFieldsCell: ReuseableTableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        facebookFieldsCell.textField.text = dataToFacebookFieldsView?[indexPath.row]
        facebookFieldsCell.textField.isUserInteractionEnabled = false
        facebookFieldsCell.label.text = labelValue[indexPath.row]
        
        return facebookFieldsCell
    }
    
}

//MARK: - UITableViewDataSource

extension FacebookFieldsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReuseableTableViewCell
        
        return self.configure(facebookFieldsCell: cell, for: indexPath)
    }
    
}

extension FacebookFieldsView: UITableViewDelegate {
    
    @objc(tableView: heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(labelValue.count)
    }
    
}

