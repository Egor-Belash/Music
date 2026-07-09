//
//  PlayerPresenter.swift
//  Music
//
//  Created by Egor on 05.07.2026.
//

import Foundation

final class PlayerPresenter: PlayerPresenterProtocol {
    
    // MARK: – Properties
    weak var view: PlayerViewProtocol?
    var router: PlayerRouterProtocol?
    private var timer: Timer?

    // MARK: – ViewDidLoad
    func viewDidLoad() {
        updatePlayerUI()
        updateProgress()
        startTimer()
    }
    
    // MARK: – DEINIT
    deinit {
        timer?.invalidate()
    }
    
    // MARK: – Functions
    func playPrevious() {
        AudioPlayerManager.shared.previous()
    }
    
    func playNext() {
        AudioPlayerManager.shared.next()
    }
    
    func pause() {
        AudioPlayerManager.shared.pause()
    }
    
    func likeButtonTapped() {
        guard let track = AudioPlayerManager.shared.currentTrack else { return }
        
        FavouritesManager.shared.toggleLiked(for: track)
        view?.updateLikeButton(isLiked: FavouritesManager.shared.isLiked(track: track))
    }
    
    func sliderValueChanged(value: TimeInterval) {
        AudioPlayerManager.shared.seek(to: value)
    }
    
    func didChangePlaybackState() {
        view?.updatePauseButton(isPlaying: AudioPlayerManager.shared.isPlaying)
    }
    
    func didChangeTrack() {
        updatePlayerUI()
    }
    
    func didTapExitButton() {
        router?.closePlayer()
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
    
    private func updatePlayerUI() {
        guard let track = AudioPlayerManager.shared.currentTrack else { return }
        
        view?.showTrack(track: track)
        view?.updatePauseButton(isPlaying: AudioPlayerManager.shared.isPlaying)
        view?.updateLikeButton(isLiked: FavouritesManager.shared.isLiked(track: track))
    }
}
