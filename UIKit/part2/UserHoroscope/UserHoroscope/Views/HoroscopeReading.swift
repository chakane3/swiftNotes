//
//  HoroscopeReading.swift
//  UserHoroscope
//
//  Created by Chakane Shegog on 1/23/22.
//

import UIKit

class HoroscopeReading: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
    }
    
    @IBAction func createAlert(_ sender: Any) {
        let alertUser = UIAlertController(title: "Too many users", message: "Delete the current user", preferredStyle: .alert)
        alertUser.addAction(UIAlertAction(title: "Stay as current sign", style: .default, handler: nil))
        alertUser.addAction(UIAlertAction(title: "Delete user", style: .default, handler: nil))
        self.present(alertUser, animated: true)
    }
}
