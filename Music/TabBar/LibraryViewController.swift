//
//  LibraryViewController.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

final class LibraryViewController: UIViewController {
    
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
        view.backgroundColor = .systemCyan
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
