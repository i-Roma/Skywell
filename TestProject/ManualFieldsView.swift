//
//  FieldsView.swift
//  TestProject
//
//  Created by Roma Balboa on 18.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

protocol DateOfBirthDelegate: class {
    func showDatePicker()
}

fileprivate struct ManualLoginConstants {
    static let labelValue = ["Email", "Name", "Date of birth", "Password", "Confirm password"]
    static let dateOfBirthday = 2
}

class ManualFieldsView: UIView, UITextFieldDelegate {

    weak var dateOfBirthDelegate: DateOfBirthDelegate?
    
    @IBOutlet var manualFieldsTableView: UITableView!
    
    var selectedDate: String? {
        didSet {
            guard selectedDate != "" else {
                return
            }
            manualFieldsTableView?.reloadData()
        }
    }

    let cellIdentifier = "\(type(of: ReuseableTableViewCell()))"
    var imediatlyValue = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let identifier = "\(type(of: self))"
        ViewConstructor.add(nib: identifier, toView: self)
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        manualFieldsTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    func configure(manualFieldsCell: ReuseableTableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        manualFieldsCell.label.text = ManualLoginConstants.labelValue[indexPath.row]
        manualFieldsCell.textField.keyboardAppearance = .dark
        
        if indexPath.row == ManualLoginConstants.dateOfBirthday {
            manualFieldsCell.textField.delegate = self
            manualFieldsCell.textField.text = self.selectedDate
        }
        
        return manualFieldsCell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.endEditing(true)
        dateOfBirthDelegate?.showDatePicker()
    }

}

//MARK: - UITableViewDataSource

extension ManualFieldsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManualLoginConstants.labelValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReuseableTableViewCell
        
        return self.configure(manualFieldsCell: cell, for: indexPath)
    }
    
}

//MARK: - UITableViewDelegate

extension ManualFieldsView: UITableViewDelegate {
    
    @objc(tableView: heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(ManualLoginConstants.labelValue.count)
    }

}
