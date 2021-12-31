//
//  ArtsitSearchController.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 12/31/21.
//

import UIKit

class ArtistSearchController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var artists = [ArtistInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // given a search query load the appropriate data
    func loadData() {
    }
}

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
