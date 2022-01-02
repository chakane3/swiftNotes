//
//  TrackListController.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 1/1/22.
//

import UIKit

class TrackListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var albumID: Int?
    var tracks = [Track]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        Tracks.fetchTracks(for: albumID ?? 0) { (result) in
            switch result {
            case .failure(let networkError):
                print("error: \(networkError)")
                
            case .success(let data):
                self.tracks = data
            }
        }
    }
}

extension TrackListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? TrackCell else {
            fatalError("check identity inspector for cell")
        }
        let track = tracks[indexPath.row]
        cell.configureCell(for: track)
        return cell
    }
}

extension TrackListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
