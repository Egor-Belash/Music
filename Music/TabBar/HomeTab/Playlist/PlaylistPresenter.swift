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
    }
    
    
}
