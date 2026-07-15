//
//  AvatarButton.swift
//  Music
//
//  Created by Egor on 15.07.2026.
//

import UIKit

final class AvatarButton: UIButton {
    
    // MARK: – INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        updateAvatar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Layout
    private func setupButton() {
        tintColor = .white
        backgroundColor = .greenColor2
        layer.cornerRadius = 18
        clipsToBounds = true
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 36),
            heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func updateAvatar() {
        if let image = UserManager.shared.avatarImage {
            setImage(image, for: .normal)
        } else {
            setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
            contentMode = .scaleAspectFill
        }
    }
}
