//
//  ComicsController.swift
//  Comics
//
//  Created by Chakane Shegog on 1/3/22.
//

import UIKit

// 2563 represents today (Jan 2, 2022)
class ComicsController: UIViewController {
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    var comicNumValue: Int = 0
    
    var comic: Comics?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepper()
        loadData(comicNum: 2563)
    }
    
    func loadData(comicNum: Int) {
        Comics.fetchComic(for: comicNum) { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
                
            case .success(let data):
                self.imageView.getImage(with: data.img) { (result) in
                    switch result {
                    case .failure(let error):
                        print("error: \(error)")
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
    }
    @IBAction func stepperChanged(_ sender: UIStepper) {
        loadData(comicNum: Int(sender.value))
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        loadData(comicNum: Int.random(in: 0...2563))
    }
    
    func configureStepper() {
        stepper.minimumValue = 0
        stepper.maximumValue = 2564
        stepper.stepValue = 1
        stepper.value = 2563
    }
}


