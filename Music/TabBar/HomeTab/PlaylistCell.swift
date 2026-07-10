//
//  PlaylistCell.swift
//  Music
//
//  Created by Egor on 30.06.2026.
//

import UIKit

final class PlaylistCell: UICollectionViewCell {
    
    // MARK: – Properties
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: – Subviews
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    // MARK: – Actions
    func configure(with model: Playlist) {
        titleLabel.text = model.title
        imageView.setImage(with: model.coverImage)
    }
    
}
