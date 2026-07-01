//
//  Extension+VC.swift
//  Music
//
//  Created by Egor on 01.07.2026.
//

import UIKit

extension UIImageView {
    func setImage(with imageName: String?) {
        guard let imageName else { // ne pustoi imageName
            image = UIImage(systemName: "music.note")
            return
        }
        
        image = UIImage(named: imageName) ?? UIImage(systemName: "music.note")
        
    }
}

