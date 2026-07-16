//
//  MainTabBarProtocols.swift
//  Music
//
//  Created by Egor on 09.07.2026.
//

import Foundation

protocol MainTabBarViewProtocol: AnyObject {
    func updatePauseButton(isPlaying: Bool)
    func showTrack(track: Track)
    func showMiniPlayer()
    func updateProgress(currentTime: TimeInterval, duration: TimeInterval)
}

protocol MainTabBarPresenterProtocol: AnyObject {
    func didChangePlaybackState()
    func didChangeTrack()
    func pauseButtonTapped()
    func miniPlayerViewTapped()
    func sliderValueChanged(value: TimeInterval)
}

protocol MainTabBarRouterProtocol: AnyObject {
    func openPlayer()
}
