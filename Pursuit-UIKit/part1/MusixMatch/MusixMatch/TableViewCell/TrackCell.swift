//
//  TrackCell.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 1/1/22.
//

import UIKit

class TrackCell: UITableViewCell {
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreNameLabel: UILabel!
    
    func configureCell(for track: Track) {
        trackNameLabel.text = track.track.track_name
        albumNameLabel.text = track.track.album_name
        artistNameLabel.text = track.track.artist_name
    }

}
