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
            
            guard let url = Bundle.main.url(forResource: "playlists", withExtension: "json") else {
                completion(.failure(.invalidURL))
                return
            }
                        
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                let playlists = try decoder.decode([Playlist].self, from: data)
                completion(.success(playlists))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
    }
}
