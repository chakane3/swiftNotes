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
    
    var comic: Comics?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        Comics.fetchComic(for: 2563) { (result) in
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
}
