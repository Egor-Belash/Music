//
//  HomeProtocols.swift
//  Music
//
//  Created by Egor on 30.06.2026.
//

protocol HomeViewProtocol: AnyObject {
    func showPlaylists(playlists: [Playlist])
    func showError()
    func showLoading()
    func hideLoading()
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapPlaylist(_ playlist: Playlist)
    func settingsTapped()
}

protocol HomeRouterProtocol: AnyObject {
    func openPlaylist(_ playlist: Playlist)
    func openSettings()
}
