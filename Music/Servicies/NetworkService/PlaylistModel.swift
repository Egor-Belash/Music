//
//  PlaylistModel.swift
//  Music
//
//  Created by Egor on 29.06.2026.
//

struct Playlist: Codable {
    let id: String
    let title: String?
    let coverImage: String?
    let tracks: [Track]
}

struct Track: Codable {
    let id: String
    let title: String?
    let artist: String?
    let coverImage: String?
    let albumCover: String?
    let songFileName: String?
}
