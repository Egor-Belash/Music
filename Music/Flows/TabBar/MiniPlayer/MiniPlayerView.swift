//
//  MiniPlayerView.swift
//  Music
//
//  Created by Egor on 27.06.2026.
//

import UIKit

protocol MiniPlayerViewDelegate: AnyObject {
    func miniPlayerViewDidTap()
    func pauseButtonTapped()
    func didChangePlaybackState()
    func didChangeTrack()
}

final class MiniPlayerView: TouchView {
    
    // MARK: – Properties
    weak var delegate: MiniPlayerViewDelegate?
    
    // MARK: – Subviews
    private let songImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.tintColor = .greenColor2
        return view
    }()
    
    private let songTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Song Title"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    private let songArtistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Song Artist"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .systemGray5
        return label
    }()
    
    private let VStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .selected)
        button.tintColor = .white
        return button
    }()
    
    private let HStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: – INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        setupGesture()
        setupNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        backgroundColor = .orange
        layer.cornerRadius = 10
    }
    
    private func setupSubviews() {
        VStackView.addArrangedSubview(songTitleLabel)
        VStackView.addArrangedSubview(songArtistLabel)
        
        HStackView.addArrangedSubview(songImageView)
        HStackView.addArrangedSubview(VStackView)
        HStackView.addArrangedSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        addSubview(HStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            songImageView.widthAnchor.constraint(equalToConstant: 50),
            songImageView.heightAnchor.constraint(equalToConstant: 50),
            
            HStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            HStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            HStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            HStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(miniPlayerTapped))
        addGestureRecognizer(tap)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(miniPlayerTapped))
        swipeUp.direction = .up
        addGestureRecognizer(swipeUp)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(trackChanged), name: .playerTrackChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stateChanged), name: .playerStateChanged, object: nil)
    }
    
    // MARK: – Actions
    @objc private func pauseButtonTapped() {
        delegate?.pauseButtonTapped()
    }
    
    @objc private func miniPlayerTapped() {
        delegate?.miniPlayerViewDidTap()
    }
    
    @objc private func trackChanged(_ notification: Notification) {
        delegate?.didChangeTrack()
    }
    
    @objc private func stateChanged() {
        delegate?.didChangePlaybackState()
    }
    
    // MARK: – UI Updating
    func updatePauseButton(isPlaying: Bool) {
        pauseButton.isSelected = isPlaying
    }
    
    func showTrack(track: Track) {
        songImageView.setImage(with: track.coverImage)
        songTitleLabel.text = track.title
        songArtistLabel.text = track.artist
    }
}
