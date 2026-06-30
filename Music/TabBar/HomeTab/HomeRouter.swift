//
//  HomeRouter.swift
//  Music
//
//  Created by Egor on 30.06.2026.
//

import UIKit

final class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = HomeViewController()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
    
    func openPlaylist(_ playlist: Playlist) {
        let vc = PlaylistViewController(playlist: playlist)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
