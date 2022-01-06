//
//  RandomUserList.swift
//  RandomUsers
//
//  Created by Chakane Shegog on 1/5/22.
//

import UIKit

class RandomUserList: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var randomUsers = [RandomUser]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        RandomUsersAPI.fetchRandomUsers() { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let data):
                self.randomUsers = data
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get the destination Vc to pass our data to
        guard let randomUserTVDetail = segue.destination as? RandomUserTVDetail, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not retrieve an instance of RandomUserTVDetail, verify class name in the identity inspector")
        }
        let user = randomUsers[indexPath.row]
        randomUserTVDetail.randomUser = user
    }
}

extension RandomUserList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = randomUsers[indexPath.row]
        cell.textLabel?.text = "\(user.name.last), \(user.name.first)"
        cell.detailTextLabel?.text = user.email
        return cell
    }
}
