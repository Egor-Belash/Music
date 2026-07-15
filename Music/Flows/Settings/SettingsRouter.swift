//
//  SettingsRouter.swift
//  Music
//
//  Created by Egor on 15.07.2026.
//

import UIKit

final class SettingsRouter: SettingsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = SettingsViewController()
        let presenter = SettingsPresenter()
        let router = SettingsRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
    
    func openLoginVC() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else
        { return }
        
        window.rootViewController = LogInRouter.build()
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionFlipFromBottom,
            animations: nil,
            completion: nil
        )
    }
}
