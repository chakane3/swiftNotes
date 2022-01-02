//
//  CustomCellViewController.swift
//  zooAnimals
//
//  Created by Chakane Shegog on 12/5/21.
//

import UIKit

class CustomCellViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var zooAnimal = [animals]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        zooAnimal = animals.zooAnimal
    }
}

extension CustomCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        zooAnimal.count
    }
    
    
    // Here we need to create our cell as? animalCell to enable us to use our configure cell function to setup our UI
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath) as? animalCell else {
            fatalError("Cannot reach animalCell")
        }
        let animal = zooAnimal[indexPath.row]
        cell.configureCell(for: animal)
        return cell
    }
}
