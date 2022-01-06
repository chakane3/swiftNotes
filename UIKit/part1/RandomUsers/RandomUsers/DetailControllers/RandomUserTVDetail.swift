//
//  RandomUserTVDetail.swift
//  RandomUsers
//
//  Created by Chakane Shegog on 1/5/22.
//

import UIKit

class RandomUserTVDetail: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    var randomUser: RandomUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        textField.text += "\(randomUser?.name.first ?? "")  \(randomUser?.name.last ?? "")"
        textField.text += "\n\(randomUser?.location.city ?? ""), \(randomUser?.location.state ?? "") \(randomUser?.location.country ?? "")"
        
        // use our UIImaveView extension to make a request for image data
        imageView.getImage(with: randomUser?.picture.medium ?? "") { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = data
                }
                
            }
        }
        
    }

}
