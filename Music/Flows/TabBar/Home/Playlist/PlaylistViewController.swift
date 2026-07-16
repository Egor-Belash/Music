//
//  PlaylistViewController.swift
//  Music
//
//  Created by Egor on 30.06.2026.
//

import UIKit

final class PlaylistViewController: UIViewController {
    
    // MARK: – Properties
    private var playlist: Playlist?
    var presenter: PlaylistPresenterProtocol?
    private var playingTrack: Track?
    private var isPlaying = false

    // MARK: – Subviews
    private let playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.tintColor = .greenColor2
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .darkColor2
        return tableView
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: – INIT
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .purple
    }
    
    private func setupSubviews() {
        view.addSubview(playlistImageView)
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlaylistTableCell.self, forCellReuseIdentifier: PlaylistTableCell.reuseIdentifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playlistImageView.topAnchor.constraint(equalTo: view.topAnchor),
            playlistImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            playlistImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            playlistImageView.heightAnchor.constraint(equalTo: playlistImageView.widthAnchor, multiplier: 1),
            
            tableView.topAnchor.constraint(equalTo: playlistImageView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: – UITableViewDataSource
extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlist?.tracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlaylistTableCell.reuseIdentifier,
            for: indexPath
        ) as? PlaylistTableCell else {
            return UITableViewCell()
        }
        
        guard let track = playlist?.tracks[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: track)

        let isCurrentTrack = track.id == playingTrack?.id && isPlaying

        cell.updatePlayerState(isPlaying: isCurrentTrack)
        
        return cell
    }
}

// MARK: – UITableViewDelegate
extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.didTapSong(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: – PlaylistViewProtocol
extension PlaylistViewController: PlaylistViewProtocol {
    func showPlaylist(playlist: Playlist) {
        self.playlist = playlist
        
        playlistImageView.setImage(with: playlist.coverImage)
        
        let color = UIImage.dominantColor(from: playlist.coverImage)
        view.backgroundColor = color
    }

    func updatePlayingTrack(track: Track?, isPlaying: Bool) {
        self.playingTrack = track
        self.isPlaying = isPlaying

        tableView.reloadData()
    }
    
}
