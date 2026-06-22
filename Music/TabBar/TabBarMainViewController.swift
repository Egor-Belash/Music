//
//  TabBarMainViewController.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let homeVC = HomeViewController()
        let libraryVC = LibraryViewController()
        
        let homeVCNav = UINavigationController(rootViewController: homeVC)
        let libraryNav = UINavigationController(rootViewController: libraryVC)
        
        homeVCNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        libraryNav.tabBarItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "music.note.square.stack"),
            selectedImage: UIImage(systemName: "music.note.square.stack.fill")
        )
        
        homeVCNav.navigationBar.prefersLargeTitles = true
        libraryNav.navigationBar.prefersLargeTitles = true
        
        viewControllers = [homeVCNav, libraryNav]
        
        selectedIndex = 0
    }
}

