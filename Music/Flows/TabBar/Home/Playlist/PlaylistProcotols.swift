//
//  PlaylistProcotols.swift
//  Music
//
//  Created by Egor on 01.07.2026.
//

protocol PlaylistViewProtocol: AnyObject {
    func showPlaylist(playlist: Playlist)
    func updatePlayingTrack(track: Track?, isPlaying: Bool)
}

protocol PlaylistPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapSong(index: Int)
}

protocol PlaylistRouterProtocol: AnyObject {
    
}
