//
//  ControlsViewController.swift
//  AppCycle-UIControls
//
//  Created by Chakane Shegog on 9/16/23.
//

import UIKit

class ControlsViewController: UIViewController {
    // MARK: - Properties and outlets
    @IBOutlet weak var switchMessageLabel: UILabel!
    @IBOutlet weak var stepperMessageLabel: UILabel!
    @IBOutlet weak var segmentMessageLabel: UILabel!
    @IBOutlet weak var sliderMessageLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ControlsViewController - viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("ControlViewController - viewWillAppear")
    }
    
    
    // MARK: - Actions
    @IBAction func switchPressed(_ sender: UISwitch) {
        if sender.isOn {
            switchMessageLabel.text = "This Switch is on"
            print("switch is on")
        } else {
            switchMessageLabel.text = "This Switch is off"
            print("switch is off")
        }
        
    }
    @IBAction func stepperPressed(_ sender: UIStepper) {
        stepperMessageLabel.text = "Looking at \(sender.value) Cohort"
        print("stepper wass pressed with value of \(sender.value)")
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentMessageLabel.text = "I'm learning iOS"
        case 1:
            segmentMessageLabel.text = "I'm learning React"
        case 2:
            segmentMessageLabel.text = "I'm learning AEM"
        default:
            segmentMessageLabel.text = "uhhhhhhhh"
        }
        
        print("segment wss pressed with value of \(sender.selectedSegmentIndex)")
    }
    
    @IBAction func sliderTouched(_ sender: UISlider) {
        sliderMessageLabel.text = "The slider value is: \(Int (sender.value))"
        print("slider was touched \(Int (sender.value))")
    }
    

}


