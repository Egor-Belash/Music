//
//  MainTabBarRouter.swift
//  Music
//
//  Created by Egor on 09.07.2026.
//

import UIKit

final class MainTabBarRouter: MainTabBarRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = MainTabBarViewController()
        let presenter = MainTabBarPresenter()
        let router = MainTabBarRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        
        return vc
    }
    
    func openPlayer() {
        let vc = PlayerRouter.build()
        viewController?.present(vc, animated: true)
    }
}
