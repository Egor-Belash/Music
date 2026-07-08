//
//  TabBarMainViewController.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    // MARK: – Subviews
    private let miniPlayerView: MiniPlayerView = {
        let mini = MiniPlayerView()
        mini.translatesAutoresizingMaskIntoConstraints = false
        return mini
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupMiniPlayer()
    }
    
    // MARK: – Layout
    private func setupTabs() {
        let homeVC = HomeRouter.build()
        let libraryVC = LibraryRouter.build()
        
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
    
    private func setupMiniPlayer() {
        view.addSubview(miniPlayerView)
        NSLayoutConstraint.activate([
            miniPlayerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            miniPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            miniPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            miniPlayerView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        miniPlayerView.delegate = self
    }
    
}

// MARK: – MiniPlayerViewDelegate
extension MainTabBarViewController: MiniPlayerViewDelegate {
    func pauseButtonTapped() {
        AudioPlayerManager.shared.pause()
    }
    
    func miniPlayerViewDidTap() {
        let vc = PlayerRouter.build()
        present(vc, animated: true)
    }
}
