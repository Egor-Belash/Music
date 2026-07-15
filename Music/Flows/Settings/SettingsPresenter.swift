//
//  SettingsPresenter.swift
//  Music
//
//  Created by Egor on 15.07.2026.
//

import Foundation
import Photos

final class SettingsPresenter: SettingsPresenterProtocol {
    
    // MARK: – Properties
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol?
    
    // MARK: – Functions
    func viewDidLoad() {
        view?.updateAvatar()
    }
    
    func didSelectImage(data: Data) {
        UserManager.shared.saveAvatar(data)
        
        NotificationCenter.default.post(name: .avatarChanged, object: nil)
        
        view?.updateAvatar()
    }
    
    func changeAvatarButtonTapped() {
        view?.showPhotoSourceAlert()
    }
    
    func gallerySelected() {
        checkGalleryStatusAction()
    }
    
    func cameraSelected() {
        checkCameraStatusAction()
    }
    
    // MARK: – Router
    func logOutButtonTapped() {
        router?.openLoginVC()
    }
    
    // MARK: – Privates
    private func checkGalleryStatusAction() {
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoStatus {
        case .authorized, .limited:
            view?.showGalleryPicker()
        case .denied:
            view?.showAlert(title: String(localized: .denied), message: String(localized: .noaccesstogallery))
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    if status == .authorized || status == .limited {
                        self?.view?.showGalleryPicker()
                    }
                }
            }
        case .restricted:
            view?.showAlert(title: String(localized: .restricted), message: String(localized: .accessisrestricted))
        default:
            break
        }
    }
    
    private func checkCameraStatusAction() {
            let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)

            switch cameraStatus {
            case .authorized:
                view?.showCameraPicker()
            case .denied:
                view?.showAlert(title: String(localized: .denied), message: String(localized: .noaccesstothecamera))
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    DispatchQueue.main.async {
                        if granted {
                            self?.view?.showCameraPicker()
                        } else {
                            self?.view?.showAlert(title: String(localized: .denied), message: String(localized: .noaccesstothecamera))
                        }
                    }
                }
            case .restricted:
                view?.showAlert(title: String(localized: .restricted), message: String(localized: .accessisrestricted))
            default:
                break
            }
        }
}
