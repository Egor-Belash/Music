//
//  PlayerViewController.swift
//  Music
//
//  Created by Egor on 26.06.2026.
//

import UIKit

final class PlayerViewController: UIViewController {
    
    // MARK: – Properties
    var presenter: PlayerPresenterProtocol?
    
    // MARK: – Subviews
    private let topBar: TopPlayerView = {
        let topBar = TopPlayerView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        return topBar
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let centeringGuide = UILayoutGuide()
    
    private let albumImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .brown
        return view
    }()
    
    private let songTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Song Title"
        label.font = .systemFont(ofSize: 22, weight: .bold)
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
    
    private let titleVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemMint
        return stackView
    }()
    
    private let titleHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemMint
        return stackView
    }()
    
    private let songSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = 0.6
        return slider
    }()
    
    private let songDurationLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0:00"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .systemGray5
        return label
    }()
    
    private let songDurationRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0:00"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = .systemGray5
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .ultraLight)), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .ultraLight)), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 75)), for: .normal)
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 75)), for: .selected)
        button.tintColor = .white
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        setupNotifications()
        updateUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemOrange
    }
    
    private func setupSubviews() {
        topBar.delegate = self
        view.addSubview(topBar)
        
        view.addSubview(imageView)
        view.addLayoutGuide(centeringGuide)
        
        titleVStackView.addArrangedSubview(songTitleLabel)
        titleVStackView.addArrangedSubview(songArtistLabel)
        
        titleHStackView.addArrangedSubview(albumImageView)
        titleHStackView.addArrangedSubview(titleVStackView)
        view.addSubview(titleHStackView)
        
        songSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.addSubview(songSlider)
        view.addSubview(songDurationLeftLabel)
        view.addSubview(songDurationRightLabel)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(backButton)
        buttonsStackView.addArrangedSubview(pauseButton)
        buttonsStackView.addArrangedSubview(forwardButton)
        view.addSubview(buttonsStackView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topBar.heightAnchor.constraint(equalToConstant: 60),
            
            centeringGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            centeringGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            centeringGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            centeringGuide.bottomAnchor.constraint(equalTo: titleHStackView.topAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            imageView.centerYAnchor.constraint(equalTo: centeringGuide.centerYAnchor),
            
            albumImageView.widthAnchor.constraint(equalToConstant: 50),
            albumImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleHStackView.bottomAnchor.constraint(equalTo: songSlider.topAnchor, constant: -20),
            titleHStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleHStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleHStackView.heightAnchor.constraint(equalToConstant: 50),
            
            songSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            songSlider.bottomAnchor.constraint(equalTo: songDurationLeftLabel.topAnchor),
            
            songDurationLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songDurationLeftLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -15),
            
            songDurationRightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            songDurationRightLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -15),
            
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(trackChanged), name: .playerTrackChanged, object: nil)
    }
    
    private func updateUI() {
        guard let track = AudioPlayerManager.shared.currentTrack else { return }
        
        imageView.setImage(with: track.coverImage)
        songTitleLabel.text = track.title
        songArtistLabel.text = track.artist
    }

    // MARK: – Actions
    @objc private func backButtonTapped() {
        presenter?.playPrevious()
    }
    
    @objc private func pauseButtonTapped() {
        pauseButton.isSelected.toggle()
        presenter?.pause()
    }
    
    @objc private func forwardButtonTapped() {
        presenter?.playNext()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        
    }
    
    @objc private func trackChanged(_ notification: Notification) {
        guard let track = notification.object as? Track else { return }

        imageView.setImage(with: track.coverImage)
        songTitleLabel.text = track.title
        songArtistLabel.text = track.artist
    }
    
}

// MARK: – TopPlayerViewDelegate
extension PlayerViewController: TopPlayerViewDelegate {
    func didTapExitButton() {
        dismiss(animated: true)
    }
    
}

// MARK: – PlayerViewProtocol
extension PlayerViewController: PlayerViewProtocol {
    
}
