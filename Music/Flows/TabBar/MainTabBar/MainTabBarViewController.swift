//
//  TabBarMainViewController.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    // MARK: – Properties
    var presenter: MainTabBarPresenterProtocol?
    
    // MARK: – Subviews
    private let miniPlayerView: MiniPlayerView = {
        let mini = MiniPlayerView()
        mini.translatesAutoresizingMaskIntoConstraints = false
        mini.isHidden = true
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
            title: String(localized: .home),
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        libraryNav.tabBarItem = UITabBarItem(
            title: String(localized: .library),
            image: UIImage(systemName: "music.note.square.stack"),
            selectedImage: UIImage(systemName: "music.note.square.stack.fill")
        )
        
        homeVCNav.navigationBar.prefersLargeTitles = true
        libraryNav.navigationBar.prefersLargeTitles = true
        
        viewControllers = [homeVCNav, libraryNav]
        
        selectedIndex = 0
    }
    
    func setMiniPlayerHidden(_ hidden: Bool) {
        miniPlayerView.isHidden = hidden
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
    func sliderValueChanged(value: TimeInterval) {
        presenter?.sliderValueChanged(value: value)
    }
    
    func didChangeTrack() {
        presenter?.didChangeTrack()
    }
    
    func didChangePlaybackState() {
        presenter?.didChangePlaybackState()
    }
    
    func pauseButtonTapped() {
        presenter?.pauseButtonTapped()
    }
    
    func miniPlayerViewDidTap() {
        presenter?.miniPlayerViewTapped()
    }
}

// MARK: – MainTabBarViewProtocol
extension MainTabBarViewController: MainTabBarViewProtocol {
    func updateProgress(currentTime: TimeInterval, duration: TimeInterval) {
        miniPlayerView.updateProgress(currentTime: currentTime, duration: duration)
    }
    
    func showMiniPlayer() {
        guard miniPlayerView.isHidden else { return }
        
        miniPlayerView.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
        miniPlayerView.isHidden = false
        miniPlayerView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.5) {
            self.miniPlayerView.transform = .identity
            self.miniPlayerView.alpha = 1
        }
    }
    
    func showTrack(track: Track) {
        miniPlayerView.showTrack(track: track)
    }
    
    func updatePauseButton(isPlaying: Bool) {
        miniPlayerView.updatePauseButton(isPlaying: isPlaying)
    }
}
