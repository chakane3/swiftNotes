//
//  ContinentsViewController.swift
//  TableViewz
//
//  Created by Chakane Shegog on 9/19/23.
//

import UIKit

class ContinentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var countries = Country.countries//{
        // property observer
//        didSet {
//            // reload the table view
//            tableView.reloadData()
//
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        print("ContinentsViewcontroller is getting data? :\(Country.countries)")
        
    }
}

extension ContinentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "continentCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        return cell
    }
}
