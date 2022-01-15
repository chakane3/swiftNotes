//
//  CreateEventController.swift
//  Schedules
//
//  Created by Chakane Shegog on 1/3/22.
//

import UIKit

enum EventState {
    case newEvent
    case existingEvent
}

class CreateEventController: UIViewController {
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventButton: UIButton!
    
    // the property we'll use to send back to ScheduleListController
    var event: Event?
    
    // its public for reading but not public for writing (its read only)
    public private(set) var eventState = EventState.newEvent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.delegate = self
        updateUI()
        
    }
    
    private func updateUI() {
        if let event = event {
            self.event = event
            datePicker.date = event.date
            eventNameTextField.text = event.name
            eventButton.setTitle("Update Event", for: .normal)
            eventState = .existingEvent
        } else {
            // instantiate a defult value for event
            event = Event(date: Date(), name: "Swift rocks")
            eventState = .newEvent
            
        }
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


