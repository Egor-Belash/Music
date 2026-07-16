//
//  PlaylistPresenter.swift
//  Music
//
//  Created by Egor on 01.07.2026.
//

import Foundation

final class PlaylistPresenter: PlaylistPresenterProtocol {
    
    // MARK: – Properties
    weak var view: PlaylistViewProtocol?
    var router: PlaylistRouterProtocol?
    private let playlist: Playlist
    
    // MARK: – INIT
    init(playlist: Playlist) {
        self.playlist = playlist
    }
    
    // MARK: – Functions
    func viewDidLoad() {
        view?.showPlaylist(playlist: playlist)
        setupNotifications()
    }
    
    func didTapSong(index: Int) {
        AudioPlayerManager.shared.play(playlist: playlist, startIndex: index)
    }

    // MARK: – Privates
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(trackChanged), name: .playerTrackChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(trackChanged), name: .playerStateChanged, object: nil)
    }

    @objc private func trackChanged() {
        view?.updatePlayingTrack(track: AudioPlayerManager.shared.currentTrack, isPlaying: AudioPlayerManager.shared.isPlaying)
    }
}
