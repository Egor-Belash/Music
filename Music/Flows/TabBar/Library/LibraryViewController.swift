//
//  LibraryViewController.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

final class LibraryViewController: UIViewController {
    
    // MARK: – Properties
    var presenter: LibraryPresenterProtocol?
    private var likedTracks: [Track] = []

    // MARK: – Subviews
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
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemCyan
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlaylistTableCell.self, forCellReuseIdentifier: PlaylistTableCell.reuseIdentifier)
        
        navigationItem.title = "Liked Songs"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

// MARK: – UITableViewDataSource
extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        likedTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlaylistTableCell.reuseIdentifier,
            for: indexPath
        ) as? PlaylistTableCell else {
            return UITableViewCell()
        }
        
        let track = likedTracks[indexPath.row]
        
        cell.configure(with: track)
        
        return cell
    }
}

// MARK: – UITableViewDelegate
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.didTapSong(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: – LibraryViewProtocol
extension LibraryViewController: LibraryViewProtocol {
    func showLikedTracks(_ tracks: [Track]) {
        self.likedTracks = tracks
        tableView.reloadData()
    }
}
