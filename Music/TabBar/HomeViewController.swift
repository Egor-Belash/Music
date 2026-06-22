//
//  HomeViewController.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: – Properties
    
    // MARK: – Subviews
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemMint
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
}

