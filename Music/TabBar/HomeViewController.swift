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
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to Player", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        return button
    }()
    
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
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: – Actions
    @objc private func buttonTapped() {
        let playerVC = PlayerViewController()
        
        playerVC.modalPresentationStyle = .pageSheet
        
        if let sheet = playerVC.sheetPresentationController {
            sheet.detents = [.large()]
        }
        
        present(playerVC, animated: true)
    }
    
}

