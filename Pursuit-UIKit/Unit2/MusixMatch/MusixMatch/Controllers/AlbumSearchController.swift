//
//  AlbumSearchController.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 12/31/21.
//

import UIKit

class AlbumSearchController: UIViewController {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
}

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
        return 150
    }
}
