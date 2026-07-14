//
//  Extension+VC.swift
//  Music
//
//  Created by Egor on 14.07.2026.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: String(localized: .ok), style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
