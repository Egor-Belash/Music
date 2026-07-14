//
//  Extension+UIImage.swift
//  Music
//
//  Created by Egor on 14.07.2026.
//

import UIKit
import ColorThiefSwift

extension UIImage {
    static func dominantColor(from imageName: String?) -> UIColor? {
        guard let imageName,
              let image = UIImage(named: imageName),
              let color = ColorThief.getColor(from: image) else {
            return nil
        }
        
        return color.makeUIColor()
        
    }
}
