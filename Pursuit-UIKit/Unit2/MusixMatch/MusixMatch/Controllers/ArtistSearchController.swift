//
//  ArtsitSearchController.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 12/31/21.
//

import UIKit

class ArtistSearchController: UIViewController {
    
    // MARK: - Outlets and Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var artists = [ArtistInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - App Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        loadData(for: "Prince")
    }
    
    
    // MARK: - Actions and functions
    // given a search query load the appropriate data
    func loadData(for artist: String) {
        Artists.fetchArtists(for: artist, completionHandler: {[weak self] (result) in
            
            switch result {
            case .failure(let networkError):
                print("error: \(networkError)")
            case .success(let data):
                self?.artists = data
            }
        })
    }
}

// MARK: - Tableview datasource methods
extension ArtistSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath)
        
        let artist = artists[indexPath.row]
        cell.textLabel?.text = artist.artist_name
        return cell
    }
}

// MARK: - Searchbar delegate methods
extension ArtistSearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // this dismisses the keyboard
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        loadData(for: searchText)
    }
}
