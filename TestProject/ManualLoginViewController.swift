//
//  ManualLoginViewController.swift
//  TestProject
//
//  Created by Roma Balboa on 16.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

fileprivate struct ManualLoginConstants {
    static let contentUp = UIEdgeInsetsMake(0, 0, 135, 0)
    static let contentDown = UIEdgeInsetsMake(0, 0, 0, 0)
    static let delay = Double(0)
    static let dateFormate = "dd-MM-yyyy"
    
    static let keyboardWarning = "If you read this error, it seems that in your iPhone Simulator disable Keyboard showing! The error was because app can't count height of keyboard, which didn't appearance. Please enable Keyboard showing in your iPhone Simulato and try again."
}

class ManualLoginViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var manualFieldsView: ManualFieldsView!
    @IBOutlet var manualViewPosition: NSLayoutConstraint!
    @IBOutlet var dataPickerPosition: NSLayoutConstraint!
    @IBOutlet var dataPicker: UIDatePicker!

    var keyboardHeight: CGFloat?
    var duration: Double?
    var curve: UInt?
    
    var isDataPicker: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isDataPicker = false
        
        manualFieldsView.dateOfBirthDelegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.detectTapOnScreen(tap:)))
        self.view.addGestureRecognizer(gestureRecognizer)
        hideKeyboard()
    }

    func detectTapOnScreen(tap: UIGestureRecognizer) {
        if isDataPicker == true {
            animateHideDataPicker()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        scrollView.contentInset = ManualLoginConstants.contentUp
    }
    
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = ManualLoginConstants.contentDown
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
//MARK: - Keyboard Appearance
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ManualLoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

//MARK: - Show Data Picker
    
    func animateShowDatePicker() {
        dataPickerPosition.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (finised) in }
    }
    
//MARK: - Hide Data Picker
    
    func animateHideDataPicker() {
        dataPickerPosition.constant = -230
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (finised) in }
    }
    
    @IBAction func createFreeAccount(_ sender: Any) {
        print("createFreeAccount")
    }
    
    @IBAction func dataPickerDoneBtn(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ManualLoginConstants.dateFormate
        let strDate = dateFormatter.string(from: dataPicker.date)
        
        manualFieldsView.selectedDate = strDate
        
        animateHideDataPicker()
    }
    
    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ManualLoginViewController: DateOfBirthDelegate {
    func showDatePicker() {
        isDataPicker = true
        self.animateShowDatePicker()
    }
}
