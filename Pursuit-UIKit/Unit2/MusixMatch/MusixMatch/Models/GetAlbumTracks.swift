//
//  GetAlbumTracks.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 1/1/22.
//

import Foundation

struct Tracks: Codable {
    let message: TracksMessageBody
}

struct TracksMessageBody: Codable {
    let body: TracksList
}

struct TracksList: Codable {
    let track_list: [Track]
}

struct Track: Codable {
    let track: TrackInfo
}

struct TrackInfo: Codable {
    let track_id: Int
    let track_name: String
    let commontrack_id: Int
    let explicit: Int
    let has_lyrics: Int
    let album_name: String
    let track_share_url: String
    let artist_name: String
    
    let primary_genres: GenreList
}

struct GenreList: Codable {
    let music_genre_list: [Genre]
}

struct Genre: Codable {
    let music_genre: GenreInfo
}

struct GenreInfo: Codable {
    let music_genre_id: Int
    let music_genre_parent_id: Int
    let music_genre_name: String
}


extension Tracks {
    static func fetchTracks(for albumID: Int, completionHandler: @escaping (Result<[Track], Errors>) -> ()) {
        let tracksEndpoint = "http://api.musixmatch.com/ws/1.1/album.tracks.get?album_id=\(albumID)&page=1&page_size=100&apikey=\(SecretKey.privateKey)"
        NetworkRequest.shared.getData(from: tracksEndpoint) { (result) in
            switch result {
            case .failure(let networkError):
                completionHandler(.failure(.networkClientError(networkError)))
                
            case .success(let data):
                do {
                    let albumInformation = try JSONDecoder().decode(Tracks.self, from: data)
                    completionHandler(.success(albumInformation.message.body.track_list))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
