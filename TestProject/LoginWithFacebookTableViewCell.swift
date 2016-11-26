//
//  LoginWithFacebookTableViewCell.swift
//  TestProject
//
//  Created by Roma Balboa on 17.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

class LoginWithFacebookTableViewCell: UITableViewCell {

    @IBOutlet var picture: UIImageView!
    @IBOutlet var fullnameFriend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        roundedImage()
    }
    
    func roundedImage() {
        var layer: CALayer = CALayer()
        layer = picture.layer
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(4)
        UIGraphicsBeginImageContext(picture.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
