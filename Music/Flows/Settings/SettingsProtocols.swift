//
//  SettingsProtocols.swift
//  Music
//
//  Created by Egor on 15.07.2026.
//
import UIKit

protocol SettingsViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
    func showPhotoSourceAlert()
    func showGalleryPicker()
    func showCameraPicker()
    func updateAvatar()
}

protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func changeAvatarButtonTapped()
    func gallerySelected()
    func cameraSelected()
    func didSelectImage(data: Data)
    func logOutButtonTapped()
}

protocol SettingsRouterProtocol: AnyObject {
    func openLoginVC()
}
