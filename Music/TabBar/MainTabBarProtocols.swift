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
}

protocol MainTabBarPresenterProtocol: AnyObject {
    func didChangePlaybackState()
    func didChangeTrack()
    func pauseButtonTapped()
    func miniPlayerViewTapped()
}

protocol MainTabBarRouterProtocol: AnyObject {
    func openPlayer()
}
