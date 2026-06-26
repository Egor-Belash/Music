//
//  TopPlayerView.swift
//  Music
//
//  Created by Egor on 26.06.2026.
//

import UIKit

protocol TopPlayerViewDelegate: AnyObject {
    func didTapExitButton()
}

final class TopPlayerView: UIView {
    
    // MARK: – Properties
    weak var delegate: TopPlayerViewDelegate?
    
    // MARK: – Subviews
    private let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.text = "Name of Playlist"
        return label
    }()
    
    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: – INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        backgroundColor = .black
    }
    
    private func setupSubviews() {
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(exitButton)
        buttonStackView.addArrangedSubview(albumNameLabel)
        buttonStackView.addArrangedSubview(menuButton)
        
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: – Actions
    @objc private func exitButtonTapped() {
        delegate?.didTapExitButton()
    }
    
    @objc private func menuButtonTapped() {
        
    }
    
}
