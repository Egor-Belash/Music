//
//  SceneDelegate.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        let onBoardingIsDone = UserDefaults.standard.bool(forKey: "onboardingIsDone")
        
        if onBoardingIsDone {
            window?.rootViewController = MainTabBarRouter.build()
        } else {
            window?.rootViewController = OnBoardingRouter.build()
        }
    }
}
