//
//  CreateEvent.swift
//  Scheduler-2
//
//  Created by Chakane Shegog on 1/16/22.
//

import UIKit

enum EventState {
    case newEvent
    case existingEvent
}

class CreateEvent: UIViewController {
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public var event: Event?
    
    // public private allows a read-only version of this property
    public private(set) var eventState = EventState.newEvent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.delegate = self
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // TODO: call save function to persist data
        super.viewWillDisappear(true)
    }
    
    private func updateUI() {
        if let event = event {
            self.event = event
            datePicker.date = event.date
            eventNameTextField.text = event.name
            eventButton.setTitle("Update Event", for: .normal)
            eventState = .existingEvent
            
        } else {
            // instantiate a default value for event
            event = Event(date: Date(), name: "")
            eventState = .newEvent
        }
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        // update the date of the event
        event?.date = sender.date
    }
}

extension CreateEvent: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss the keyboard
        textField.resignFirstResponder()
        
        // update the name of the event
        event?.name = textField.text ?? "no event name"
        return true
    }
}
