//
//  GetArtistAlbum.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 12/31/21.
//

import Foundation

struct Albums: Codable {
    let message: AlbumMessageBody
}

struct AlbumMessageBody: Codable {
    let body: AlbumList
}

struct AlbumList: Codable {
    let album_list: [Album]
}

struct Album: Codable {
    let album: AlbumInfo
}

struct AlbumInfo: Codable {
    let album_id: Int
    let album_name: String
    let artist_name: String
    let album_release_date: String
}

extension Albums {
    // the input here is an int
    static func fetchAlbums(for artistID: Int, completionHandler: @escaping (Result<[Album], Errors>) -> ()) {
        
        let albumEndpoint = "http://api.musixmatch.com/ws/1.1/artist.albums.get?artist_id=\(artistID)&s_release_date=desc&g_album_name=1&page=1&page_size=100&apikey=\(SecretKey.privateKey)"
        
        NetworkRequest.shared.getData(from: albumEndpoint) { (result) in
            switch result {
            case .failure(let networkError):
                completionHandler(.failure(.networkClientError(networkError)))
            
            case .success(let data):
                // decode our json
                do {
                    let albumInformation = try JSONDecoder().decode(Albums.self, from: data)
                    completionHandler(.success(albumInformation.message.body.album_list))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
