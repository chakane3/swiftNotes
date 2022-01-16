//
//  SettingsView.swift
//  ProgramaticUI
//
//  Created by Chakane Shegog on 1/16/22.
//

import UIKit

class SettingsView: UIView {
    
    // lazy property initializer
    public lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // add subviews here
        setupPickerViewConstraints()
        
    }
    
    private func setupPickerViewConstraints() {
        // 1.
        addSubview(pickerView)
        
        // 2.
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 3. setup constraints
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }

}
