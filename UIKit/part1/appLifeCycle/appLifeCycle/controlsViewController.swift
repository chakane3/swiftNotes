//
//  controlsViewController.swift
//  appLifeCycle
//
//  Created by Chakane Shegog on 12/5/21.
//

import UIKit

class controlsViewController: UIViewController {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    
    // use a property observee to change the switch value when the user interacts with it
    var switchValue: Bool = true {
        didSet {
            // update switchLabel text
            switchLabel.text = "This switch is \(switchControl.isOn ? "on" : "off")"
        }
    }
    
    // use a property observer to change how many clicks when the user interacts with it
    var numberofClicks: Double = 0.0 {
        didSet {
            stepperLabel.text = "You clicked \(numberofClicks) many times"
        }
    }
    
    // use a property observer to change the value when the user interacts with it.
    var currentSegmentIndex: Int = 0 {
        didSet {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                imageView.image = #imageLiteral(resourceName: "cat")
                
            case 1:
                imageView.image = #imageLiteral(resourceName: "dog")
                
            default:
                imageView.image = #imageLiteral(resourceName: "pursuit")
            }
        }
    }
    
    var currentYear: Float = 2021 {
        didSet {
            sliderLabel.text = String(format: "%0.f", sliderControl.value)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepper()
        configureSlider()
    }
    
    // this is how we control out stepper
    func configureStepper() {
        stepperControl.minimumValue = 0.0 // set the minimum number
        stepperControl.maximumValue = 800.0 // set the maximum number
        stepperControl.stepValue = 1.0  // how many steps are we going forward/backward
        
        stepperControl.value = 0.0 // initialize
    }
    
    func configureSlider() {
        sliderControl.minimumValue = 1995
        sliderControl.maximumValue = 2022
        sliderControl.value = 2016
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        switchValue = sender.isOn
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        numberofClicks = sender.value
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        currentSegmentIndex = sender.selectedSegmentIndex
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        currentYear = sender.value
    }
}
