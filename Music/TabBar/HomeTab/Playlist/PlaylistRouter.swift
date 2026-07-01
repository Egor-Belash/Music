//
//  PlaylistRouter.swift
//  Music
//
//  Created by Egor on 01.07.2026.
//

import UIKit

final class PlaylistRouter: PlaylistRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build(with playlist: Playlist) -> UIViewController {
        let vc = PlaylistViewController(playlist: playlist)
        let presenter = PlaylistPresenter(playlist: playlist)
        let router = PlaylistRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
}
