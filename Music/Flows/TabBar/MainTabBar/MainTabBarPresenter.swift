//
//  MainTabBarPresenter.swift
//  Music
//
//  Created by Egor on 09.07.2026.
//

final class MainTabBarPresenter: MainTabBarPresenterProtocol {
    
    // MARK: – Properties
    weak var view: MainTabBarViewProtocol?
    var router: MainTabBarRouterProtocol?
    
    // MARK: – Functions
    func didChangePlaybackState() {
        view?.updatePauseButton(isPlaying: AudioPlayerManager.shared.isPlaying)
    }
    
    func didChangeTrack() {
        guard let track = AudioPlayerManager.shared.currentTrack else { return }

        view?.showTrack(track: track)
        view?.showMiniPlayer()
    }
    
    func pauseButtonTapped() {
        AudioPlayerManager.shared.pause()
        view?.updatePauseButton(isPlaying: AudioPlayerManager.shared.isPlaying)
    }
    
    func miniPlayerViewTapped() {
        router?.openPlayer()
    }
}
