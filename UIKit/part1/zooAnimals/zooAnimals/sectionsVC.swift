//
//  sectionsVC.swift
//  zooAnimals
//
//  Created by Chakane Shegog on 12/5/21.
//

import UIKit

class sectionsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // This time we want an array of arrays
    // each array inside out array contains animals from its classification
    var zooAnimals = [[animals]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        zooAnimals = animals.classificationSections()
    }

}

extension sectionsVC: UITableViewDataSource {
    
    // how many sections do we have?
    func numberOfSections(in tableView: UITableView) -> Int {
        zooAnimals.count
    }
    
    // how many rows per section?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        zooAnimals[section].count
    }
    
    // configure our UI
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath) as? animalCell else {
            fatalError("could not reach animalCell")
        }
        let animal = zooAnimals[indexPath.section][indexPath.row]
        cell.configureCell(for: animal)
        return cell
    }
    
    // what is the title for each section?
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return zooAnimals[section].first?.classification
    }
}
