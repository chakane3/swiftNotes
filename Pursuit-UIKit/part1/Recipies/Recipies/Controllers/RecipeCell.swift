//
//  RecipeCell.swift
//  Recipies
//
//  Created by Chakane Shegog on 12/22/21.
//

import UIKit

class RecipeCell: UITableViewCell {
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    func configureCell(for recipe: Recipe) {
        recipeLabel.text = recipe.label
        
        // set the image for Recipe
        // we need to use a capture list ([weak self] or [unowned self]) to break strong reference cycles
        recipeImageView.getImage(with: recipe.image) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.recipeImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                // right now were in the global/background thread
                // were on those threads because we have an async call which are done in the
                // background thread and we need to dispatch our UI data to the main thread
                DispatchQueue.main.async {
                    self?.recipeImageView.image = image
                }
            }
        }
    }
}


