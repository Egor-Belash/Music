//
//  LibraryRouter.swift
//  Music
//
//  Created by Egor on 07.07.2026.
//

import UIKit

final class LibraryRouter: LibraryRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = LibraryViewController()
        let presenter = LibraryPresenter()
        let router = LibraryRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
    
    func openSettings() {
        let vc = SettingsRouter.build()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
