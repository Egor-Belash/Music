//
//  LibraryPresenter.swift
//  Music
//
//  Created by Egor on 07.07.2026.
//

import Foundation

final class LibraryPresenter: LibraryPresenterProtocol {
    
    // MARK: – Properties
    weak var view: LibraryViewProtocol?
    var router: LibraryRouterProtocol?
    private var likedPlaylist: Playlist = Playlist(id: "0000", title: String(localized: .likedSongs), coverImage: nil, tracks: [])
    
    // MARK: – DEINIT
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: – Functions
    func viewDidLoad() {
        setupNotifications()
        showLikedTracks()
    }
    
    func didTapSong(at index: Int) {
        AudioPlayerManager.shared.play(playlist: likedPlaylist, startIndex: index)
    }
    
    // MARK: – Notifications
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favouritesChanged),
            name: .favouritesChanged,
            object: nil
        )
    }
    
    // MARK: – Actions
    @objc private func favouritesChanged() {
        showLikedTracks()
    }
    
    // MARK: – Privates
    private func showLikedTracks() {
        let tracks = FavouritesManager.shared.likedTracks
        
        likedPlaylist = Playlist(id: "0000", title: String(localized: .likedSongs), coverImage: nil, tracks: tracks)
        
        view?.showLikedTracks(tracks)
    }
}
