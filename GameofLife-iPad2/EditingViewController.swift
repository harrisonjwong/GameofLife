//
//  EditingViewController.swift
//  GameofLife-iPad2
//
//  Created by Alex Cao & Harrison Wong on 12/02/2016.
//  Copyright © 2016 Alex Cao & Harrison Wong. All rights reserved.
//

import UIKit

class EditingViewController : UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var templatePicker: UIPickerView!
    @IBOutlet var dateLabel: UILabel!
    
    var pickerDataSource = ["Select", "Blank", "Basic", "Glider Gun"]
    
    var colony: Colony! {
        didSet {
            self.configureView()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dateLabel.text = dateFormatter.stringFromDate(colony.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.templatePicker.dataSource = self
        self.templatePicker.delegate = self
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 0) {
        } else if (row == 1) {
            self.colony.setTemplate("blank")
        } else if (row == 2) {
            self.colony.setTemplate("basic")
        } else if (row == 3) {
            self.colony.setTemplate("glidergun")
        }
    }
    
    func configureView() {
        if let detail = self.colony {
            if let field = self.nameField {
                field.text = detail.name
            }
        }
    }
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        colony.name = nameField.text ?? ""
        
        
//        print(colony.aliveCells)
        
    }
    
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
