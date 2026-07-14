//
//  Extension+UITextField.swift
//  Music
//
//  Created by Egor on 14.07.2026.
//

import UIKit

extension UITextField {
    func setupPasswordVisibilityToggle() {
        let button = UIButton(type: .custom)
        
        let eyeIcon = UIImage(systemName: "eye.slash")
        button.setImage(eyeIcon, for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        self.rightView = button
        self.rightViewMode = .always
        self.isSecureTextEntry = true
    }

    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        guard let textField = sender.superview as? UITextField else { return }
        
        sender.isSelected.toggle()
        textField.isSecureTextEntry.toggle()
        
        if let textRange = textField.selectedTextRange {
            textField.selectedTextRange = nil
            textField.selectedTextRange = textRange
        }
    }
    
}
