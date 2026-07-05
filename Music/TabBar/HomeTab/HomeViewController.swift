//
//  HomeViewController.swift
//  Music
//
//  Created by Egor on 22.06.2026.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: – Properties
    private var playlists: [Playlist] = []
    var presenter: HomePresenterProtocol?
    
    // MARK: – Subviews
    private let layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
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
        view.backgroundColor = .systemMint
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlaylistCell.self, forCellWithReuseIdentifier: PlaylistCell.reuseIdentifier)
        
        view.addSubview(loadingView)
        view.addSubview(errorView)
        errorView.delegate = self
        
        navigationItem.title = "Home"
        navigationItem.largeTitleDisplayMode = .always
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorView.heightAnchor.constraint(equalTo: errorView.widthAnchor, multiplier: 0.43),
        ])
    }
    
}

// MARK: – UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlaylistCell.reuseIdentifier,
            for: indexPath
        ) as? PlaylistCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: playlists[indexPath.row])
        
        return cell
    }
    
}

// MARK: – UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 40, height: 400)
    }

}

// MARK: – UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let playlist = playlists[indexPath.row]
        
        presenter?.didTapPlaylist(playlist)
    
    }
}

// MARK: – HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func showLoading() {
        loadingView.isHidden = false
    }
    
    func hideLoading() {
        loadingView.isHidden = true
    }
    
    func showPlaylists(playlists: [Playlist]) {
        self.playlists = playlists
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        print(message)
        errorView.isHidden = false
    }
    
}

extension HomeViewController: ErrorViewDelegate {
    func reloadButtonTapped() {
        errorView.isHidden = true
        presenter?.viewDidLoad()
    }
}
