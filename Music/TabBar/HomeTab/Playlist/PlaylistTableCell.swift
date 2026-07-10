//
//  PlaylistTableCell.swift
//  Music
//
//  Created by Egor on 01.07.2026.
//

import UIKit

final class PlaylistTableCell: UITableViewCell {
    
    // MARK: – Properties
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: – Subviews
    private let songImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .red
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
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
        stackView.spacing = 1
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let titleHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()

    // MARK: – INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        songImageView.image = nil
        songTitleLabel.text = nil
        songArtistLabel.text = nil
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        contentView.backgroundColor = .darkColor2
    }
    
    private func setupSubviews() {
        titleVStackView.addArrangedSubview(songTitleLabel)
        titleVStackView.addArrangedSubview(songArtistLabel)
        
        titleHStackView.addArrangedSubview(songImageView)
        titleHStackView.addArrangedSubview(titleVStackView)
        contentView.addSubview(titleHStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            songImageView.widthAnchor.constraint(equalToConstant: 60),
            songImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleHStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleHStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleHStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleHStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
        ])
    }
    
    // MARK: – Actions
    func configure(with track: Track) {
        songTitleLabel.text = track.title
        songArtistLabel.text = track.artist
        
        songImageView.setImage(with: track.coverImage)
    }
}
