//
//  LibraryProtocols.swift
//  Music
//
//  Created by Egor on 07.07.2026.
//

protocol LibraryViewProtocol: AnyObject {
    func showLikedTracks(_ tracks: [Track])
    func updatePlayingTrack(track: Track?, isPlaying: Bool)
}

protocol LibraryPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapSong(at index: Int)
    func settingsTapped()
}

protocol LibraryRouterProtocol: AnyObject {
    func openSettings()
}
