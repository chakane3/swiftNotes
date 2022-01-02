//
//  AlbumCell.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 1/1/22.
//

import UIKit

class AlbumCell: UITableViewCell {
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumArtist: UILabel!
    @IBOutlet weak var albumReleaseDate: UILabel!
    
    
    func configureCell(for album: Album) {
        albumName.text = album.album.album_name
        albumArtist.text = album.album.artist_name
        albumReleaseDate.text = album.album.album_release_date
    }
    
}
