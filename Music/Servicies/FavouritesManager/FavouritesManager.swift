//
//  FavouritesManager.swift
//  Music
//
//  Created by Egor on 08.07.2026.
//

import Foundation

final class FavouritesManager {
    
    // MARK: – Singleton
    static let shared = FavouritesManager()
    
    // MARK: – Properties
    private(set) var likedTracks: [Track] = []
    
    // MARK: – INIT
    private init() {
        loadLikedTracks()
    }
    
    // MARK: – Actions
    func toggleLiked(for track: Track) {
        if let index = likedTracks.firstIndex(where: { $0.id == track.id }) {
            likedTracks.remove(at: index)
        } else {
            likedTracks.append(track)
        }
        
        NotificationCenter.default.post(name: .favouritesChanged, object: nil)
        saveLikedTracks()
    }
    
    func isLiked(track: Track) -> Bool {
        return likedTracks.contains(where: { $0.id == track.id })
    }
    
    func saveLikedTracks() {
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(likedTracks)
            UserDefaults.standard.set(data, forKey: "likedTracks")
        } catch {
            print("Saving liked tracks error: \(error)")
        }
    }
    
    func loadLikedTracks() {
        guard let data = UserDefaults.standard.data(forKey: "likedTracks") else { return }
        
        do {
            let decoder = JSONDecoder()
            likedTracks = try decoder.decode([Track].self, from: data)
        } catch {
            print("Ошибка при загрузке треков: \(error)")
        }
    }
}
