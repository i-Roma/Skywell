//
//  ReuseableTableViewCell.swift
//  TestProject
//
//  Created by Roma Balboa on 19.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class ReuseableTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.layer.borderColor = Colors.lightGray.cgColor
        textField.layer.borderWidth = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
