//
//  ViewController.swift
//  zooAnimals
//
//  Created by Chakane Shegog on 12/5/21.
//

import UIKit

class basicVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // bring in data from our model
    var zooAnimals = [animals]() {
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
        zooAnimals = animals.zooAnimal
    }
}

extension basicVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        zooAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath)
        let animal = zooAnimals[indexPath.row]
        cell.textLabel?.text = animal.name
        cell.detailTextLabel?.text = animal.origin
        return cell
    }
}

