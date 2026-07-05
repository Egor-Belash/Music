//
//  PlayerProtocols.swift
//  Music
//
//  Created by Egor on 05.07.2026.
//

protocol PlayerViewProtocol: AnyObject {
    
}

protocol PlayerPresenterProtocol: AnyObject {
    func playPrevious()
    func playNext()
    func pause()
}

protocol PlayerRouterProtocol: AnyObject {
    
}
