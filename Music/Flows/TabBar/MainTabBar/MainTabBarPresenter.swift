//
//  MainTabBarPresenter.swift
//  Music
//
//  Created by Egor on 09.07.2026.
//
import Foundation

final class MainTabBarPresenter: MainTabBarPresenterProtocol {
    
    // MARK: – Properties
    weak var view: MainTabBarViewProtocol?
    var router: MainTabBarRouterProtocol?
    private var timer: Timer?
    
    // MARK: – Functions
    func didChangePlaybackState() {
        view?.updatePauseButton(isPlaying: AudioPlayerManager.shared.isPlaying)
    }
    
    func didChangeTrack() {
        guard let track = AudioPlayerManager.shared.currentTrack else { return }

        view?.showTrack(track: track)
        view?.showMiniPlayer()
        startTimer()
    }
    
    func pauseButtonTapped() {
        AudioPlayerManager.shared.pause()
        view?.updatePauseButton(isPlaying: AudioPlayerManager.shared.isPlaying)
    }
    
    func sliderValueChanged(value: TimeInterval) {
        
    }
    
    func miniPlayerViewTapped() {
        router?.openPlayer()
    }
    
    // MARK: – Privates
    private func updateProgress() {
        let currentTime = AudioPlayerManager.shared.currentTime
        let duration = AudioPlayerManager.shared.duration
        
        view?.updateProgress(currentTime: currentTime, duration: duration)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.updateProgress()
        }
    }
}
