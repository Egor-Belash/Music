//
//  UserManager.swift
//  Music
//
//  Created by Egor on 15.07.2026.
//

import UIKit

final class UserManager {

    // MARK: – Singletone
    static let shared = UserManager()

    // MARK: – Properties
    private let avatarFileName = "userAvatar.jpg"
    var avatarImage: UIImage? {

        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(avatarFileName)

        guard let url else { return nil }

        return UIImage(contentsOfFile: url.path)
    }

    // MARK: – Functions
    func saveAvatar(_ data: Data) {

        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(avatarFileName)

        guard let url else { return }

        do {
            try data.write(to: url)
        } catch {
            print("Ошибка сохранения аватара:", error)
        }
    }
}
