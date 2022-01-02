//
//  animalCell.swift
//  zooAnimals
//
//  Created by Chakane Shegog on 12/5/21.
//

import UIKit

class animalCell: UITableViewCell {

    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalClassification: UILabel!
    @IBOutlet weak var animalDescription: UILabel!
    
    func configureCell(for animal: animals) {
        animalImage.image = UIImage(named: animal.imageNumber.description)
        animalName.text = animal.name
        animalDescription.text = animal.origin
        animalClassification.text = animal.classification
    }
}
