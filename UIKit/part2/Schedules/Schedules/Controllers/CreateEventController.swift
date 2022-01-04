//
//  CreateEventController.swift
//  Schedules
//
//  Created by Chakane Shegog on 1/3/22.
//

import UIKit

class CreateEventController: UIViewController {
    @IBOutlet weak var createEventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createEventTextField.delegate = self
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        // update the date of the event
        event?.date = sender.date
    }
}

extension CreateEventController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        event?.name = textField.text ?? "no event name"
        return true
    }
}


