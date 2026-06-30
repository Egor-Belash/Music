//
//  NetworkService.swift
//  Music
//
//  Created by Egor on 29.06.2026.
//

import Foundation

// MARK: – Network Errors
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data in response"
        case .httpError(let statusCode):
            return "HTTP Error \(statusCode)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

final class NetworkService {
    
    // MARK: – Singleton
    static let shared = NetworkService()
    
    // MARK: – INIT
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 10
        configuration.waitsForConnectivity = true
    }
    
    // MARK: – Fetch Playlists
    func fetchPlaylists(completion: @escaping (Result<[Playlist], NetworkError>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let playlists = [
                Playlist(
                    id: "1",
                    title: "Eurovision 2026",
                    coverImage: "eurovision-playlist-cover",
                    tracks: [
                        Track(
                            id: "1",
                            title: "Bangaranga",
                            artist: "DARA",
                            coverImage: nil,
                            albumCover: nil,
                            songName: nil
                        ),
                        Track(
                            id: "2",
                            title: "Michelle",
                            artist: "Noam Bettan",
                            coverImage: nil,
                            albumCover: nil,
                            songName: nil
                        ),
                        
                    ]
                ),
                Playlist(
                    id: "2",
                    title: "jdajdd",
                    coverImage: nil,
                    tracks: [
                        Track(
                            id: "1234",
                            title: "",
                            artist: "",
                            coverImage: "",
                            albumCover: "",
                            songName: ""
                        )
                    ]
                )
            ]
            
            DispatchQueue.main.async {
                completion(.success(playlists))
            }
            
        }
        
    }

}
