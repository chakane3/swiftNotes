//
//  ViewController.swift
//  TableViewz
//
//  Created by Chakane Shegog on 9/16/23.
//

import UIKit

class CountriesViewController: UIViewController {
    // MARK: - outlets and properties
    @IBOutlet weak var tableView: UITableView!
//    private var countries = Country.countries // data for the tableview [Country]
    
    // didSet is a listner when we reload the table view.
    // this will be useful for the sorting button we have
    private var countries = [Country]() {
        // property observer
        didSet {
            // reload the table view
            tableView.reloadData()
            
        }
    }
    
    private var sortAscending = false
    
    // MARK: - viewcontroller lifecycle methds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 1: Set the datasource object
        // the datasource is how we will get data into our table view. The viewcontroller will handle this
        // self is the ViewController instance
        tableView.dataSource = self
        
        sortData(true)
        
        // test our country data
        print("There are \(Country.countries.count) countries in our struct")
    }
    
    // MARK: - Actions
    @IBAction func sortButtonPressed(_ sender: Any) {
        sortAscending.toggle()
        sortData(sortAscending)
    }
    
    func sortData(_ sortAscending: Bool) {
        if sortAscending {
            // the table view will reload here because were suing "didSet"
            countries = Country.countries.sorted { $0.name < $1.name }
            
            navigationItem.rightBarButtonItem?.title = "Sort Z-A"
        } else {
            countries = Country.countries.sorted { $0.name > $1.name }
            navigationItem.rightBarButtonItem?.title = "Sort A-Z"
        }
    }
}

// MARK: - Extensions And Protocols
// Step 2: Conform to UITableViewDataSource
// Theres 2 requires methods we'll need to implement:
// cellForRow and numberOfRowsInSection
extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
            let arrayOfArrays = [ [1, 2, 3], [4, 5, 6] ]
            arrayOfArrays[indexPath.section][indexPath.row] // this is how well access this using IndexPath
        
            let flatArray = [1, 2, 3]
            flatArray[indexPath.row] // this is how well access using Index Path
        */
        
        // dequeueReuseablecell recycles a cell if it exists. if one does not exist then a new one is created
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        // here we want to get the object at the current indexPath
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.countryDescription
        return cell
    }
}

// tableViews
