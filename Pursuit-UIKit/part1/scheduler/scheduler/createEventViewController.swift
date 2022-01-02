//
//  ViewController.swift
//  scheduler
//
//  Created by Chakane Shegog on 12/7/21.
//

import UIKit

class createEventViewController: UIViewController {
    @IBOutlet weak var eventField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventField.delegate = self
        event = Event(name: "Swifty 4 life", date: Date())
    }

    // along with the IBOutlet we need and IBAction to update the event date
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        event?.date = sender.date
    }
}

// we need to conform to UITextField delegate to use it
extension createEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // dismiss the keyboard
        textField.resignFirstResponder()
        
        // update the name of the event
        event?.name = textField.text ?? "no event name"
        return true
    }
}

