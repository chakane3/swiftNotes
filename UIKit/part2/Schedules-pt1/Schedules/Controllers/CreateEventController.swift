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
    
    // the property we'll use to send back to ScheduleListController
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createEventTextField.delegate = self
        event = Event(date: Date(), name: "Swift rocks")
    }
    
    
    // captures users date
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        // update the date of the event
        event?.date = sender.date
    }
}

// captures the name of the event
extension CreateEventController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        event?.name = textField.text ?? "no event name"
        return true
    }
}


