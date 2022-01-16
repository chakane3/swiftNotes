//
//  SettingsViewController.swift
//  ProgramaticUI
//
//  Created by Chakane Shegog on 1/15/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // add picker to this view
    private let settingsView = SettingsView()
    override func loadView() {
        view = settingsView
    }
    
    private let colors = ["Red", "Green", "Blue", "White"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemCyan
        
        // configure delegate and datsource of pickerview
        settingsView.pickerView.dataSource = self
        settingsView.pickerView.delegate = self
        
        let colorName = colors[0]
        view.backgroundColor = UIColor(named: colorName)
        
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    
    // how many columns?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // how many rows?
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        colors.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let colorName = colors[row]
        view.backgroundColor = UIColor(named: colorName)
        
    }
    
}

