//
//  ViewController.swift
//  getR
//
//  Created by Chakane Shegog on 12/21/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    // jokes data
    var jokes = [Joke]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureJokesTV()
        loadJokes()
        print(jokes)
    }
    
    // private methods
    func configureJokesTV() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadJokes() {
        JokeAPI.manager.getJokes { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case let .success(fetchedJokes):
                    dump(fetchedJokes)
                
                case let .failure(error):
                    let alertVC = UIAlertController(title: "Error", message: "Error fetching the jokes occured: \(error.description)", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        let joke = jokes[indexPath.row]
        cell.textLabel?.text = joke.setup
        cell.detailTextLabel?.text = joke.delivery
        return cell
    }
}

