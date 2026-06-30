//
//  PlaylistViewController.swift
//  Music
//
//  Created by Egor on 30.06.2026.
//

import UIKit

final class PlaylistViewController: UIViewController {
    
    // MARK: – Properties
    private var playlist: Playlist

    
    // MARK: – Subviews
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: – INIT
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .purple
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
