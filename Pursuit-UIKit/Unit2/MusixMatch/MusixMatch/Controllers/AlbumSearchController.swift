//
//  AlbumSearchController.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 12/31/21.
//

import UIKit

enum SearchScope {
    case albumName
    case releaseDate
}

class AlbumSearchController: UIViewController {
    
    // MARK: - Properties and outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var artistID: Int?
    var albums = [Album]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var currentScope = SearchScope.albumName
    var searchQuery = "" {
        didSet {
            switch currentScope {
                
                // filter our data depending on whats in the search query
            case .albumName:
                Albums.fetchAlbums(for: artistID ?? 0, completionHandler: { [weak self] (result) in
                    switch result {
                    case .failure(let networkError):
                        print("error: \(networkError)")
                        
                    case .success(let data):
                        self?.albums = data.filter {$0.album.album_name.lowercased().contains(self?.searchQuery.lowercased() ?? "mp")}
                    }
                })
                
            case .releaseDate:
                Albums.fetchAlbums(for: artistID ?? 0, completionHandler: {[weak self] (result) in
                    switch result {
                    case .failure(let networkError):
                        print("error: \(networkError)")
                        
                    case .success(let data):
                        self?.albums = data.filter {$0.album.album_release_date.lowercased().contains(self?.searchQuery.lowercased() ?? "mp")}
                    }
                })
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        Albums.fetchAlbums(for: artistID ?? 0, completionHandler: {[weak self] (result) in
            switch result {
            case .failure(let networkError):
                print("error: \(networkError)")
                
            case .success(let data):
                self?.albums = data
            }
        })
    }
    
    func filterHeadlines(for searchText: String) {
        guard !searchText.isEmpty else { return }
        // well filter our albums by name
        Albums.fetchAlbums(for: artistID ?? 0, completionHandler: { [weak self] (result) in
            switch result {
            case .failure(let networkError):
                print("error: \(networkError)")
                
            case .success(let data):
                self?.albums = data.filter {$0.album.album_name.lowercased().contains(searchText.lowercased())}
            }
        })
    }
    
    // send albumID to albumDetail ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let trackListVC = segue.destination as? TrackListController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("identty inspector on detail controller")
        }
        let album = albums[indexPath.row]
        trackListVC.albumID = album.album.album_id
    }
}

// MARK: - Searchbar delegate functions
extension AlbumSearchController: UISearchBarDelegate {
    
    // dismisses the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // if the searchText is empty then just load data as normal
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .albumName
            break
        case 1:
            currentScope = .releaseDate
            break
        default:
            print("not a valid scope")
        }
    }
}


// MARK: - TableView Datasource and Delegate methods
extension AlbumSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumCell else {
            fatalError("check identity inspector for tableview cell")
        }
        let album = albums[indexPath.row]
        cell.configureCell(for: album)
        return cell
    }
}

extension AlbumSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
