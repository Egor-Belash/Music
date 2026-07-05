//
//  PlayerRouter.swift
//  Music
//
//  Created by Egor on 05.07.2026.
//

import UIKit

final class PlayerRouter: PlayerRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = PlayerViewController()
        let presenter = PlayerPresenter()
        let router = PlayerRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
}
