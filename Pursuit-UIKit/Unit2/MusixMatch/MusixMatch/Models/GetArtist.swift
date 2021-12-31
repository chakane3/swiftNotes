//
//  GetArtist.swift
//  MusixMatch
//
//  Created by Chakane Shegog on 12/31/21.
//

import Foundation


struct Artists: Codable {
    let message: MessageBody
}

struct MessageBody: Codable {
    let body: ArtistsList
}

struct ArtistsList: Codable {
    let artist_list: Artist
}

struct Artist: Codable {
    let artist: [ArtistInfo]
}

struct ArtistInfo: Codable {
    let artist_id: Int
    let artist_name: String
    let artist_country: String
}


extension Artists {
    static func fetchArtists(for name: String, completionHandler: @escaping (Result<[ArtistInfo], Errors>) -> ()) {
        let name = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "nil"
        let artistEndpoint = "http://api.musixmatch.com/ws/1.1/artist.search?q_artist=\(name)&page_size=5&apikey=\(SecretKey.privateKey)"
        NetworkRequest.shared.getData(from: artistEndpoint) { (result) in
            switch result {
            case .failure(let networkError):
                completionHandler(.failure(.networkClientError(networkError)))
                
            case .success(let data):
                
                // decode our json
                do {
                    let artistInformation = try JSONDecoder().decode(Artists.self, from: data)
                    completionHandler(.success(artistInformation.message.body.artist_list.artist))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
