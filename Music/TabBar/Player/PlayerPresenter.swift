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
    
    
}
