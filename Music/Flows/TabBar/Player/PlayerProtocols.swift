//
//  PlayerProtocols.swift
//  Music
//
//  Created by Egor on 05.07.2026.
//

import Foundation

protocol PlayerViewProtocol: AnyObject {
    func updatePauseButton(isPlaying: Bool)
    func updateLikeButton(isLiked: Bool)
    func updateProgress(currentTime: TimeInterval, duration: TimeInterval)
    func updateAlbumName(name: String)
    func showTrack(track: Track)
}

protocol PlayerPresenterProtocol: AnyObject {
    func viewDidLoad()
    func playPrevious()
    func playNext()
    func pause()
    func likeButtonTapped()
    func sliderValueChanged(value: TimeInterval)
    func didChangePlaybackState()
    func didChangeTrack()
    func didTapExitButton()
}

protocol PlayerRouterProtocol: AnyObject {
    func closePlayer()
}
