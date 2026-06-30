//
//  HomePresenter.swift
//  Music
//
//  Created by Egor on 30.06.2026.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    
    // MARK: – Properties
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    private var playlists: [Playlist] = []
    
    
    // MARK: – Functions
    func viewDidLoad() {
        fetchPlaylists()
    }
    
    func didTapPlaylist(_ playlist: Playlist) {
        router?.openPlaylist(playlist)
    }
    
    // MARK: – Privates
    func fetchPlaylists() {
        NetworkService.shared.fetchPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.view?.showPlaylists(playlists: playlists)
                case .failure(let error):
                    self?.view?.showError(message: "Failed to fetch data:\n\(error.localizedDescription)")
                }
            }
        }
        
    }
}
