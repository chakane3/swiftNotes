//
//  ViewController.swift
//  Recipies
//
//  Created by Chakane Shegog on 12/22/21.
//

import UIKit

class RecipeSearchController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // recipes array
    var recipes = [Recipe]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchRecipes(searchQuery: "Beef")
    }
    
    // this function takes the users query and performs our network request
    func searchRecipes(searchQuery: String) {
        RecipeAPI.fetchRecipe(for: searchQuery, completion: {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let recipes):
                self?.recipes = recipes
            }
        })
    }
}


// MARK: - TableView datasource and delegate methods
extension RecipeSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCell else {
            fatalError("could not dequeue recipe cell")
        }
        
        let recipe = recipes[indexPath.row]
        cell.configureCell(for: recipe)
        return cell
    }
}

extension RecipeSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}


// MARK: - Searchbar datasource and delegate methods
extension RecipeSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // dismiss they keyboard when the user clicks the search button
        searchBar.resignFirstResponder()
        
        // we need to unwrap the searchBar.text property because its an optional
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchRecipes(searchQuery: searchText)
    }
}
