//
//  SettingsViewController.swift
//  Music
//
//  Created by Egor on 15.07.2026.
//

import UIKit
import Photos

final class SettingsViewController: UIViewController {
    
    // MARK: – Properties
    var presenter: SettingsPresenterProtocol?
    
    // MARK: – Subviews
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    private let changeAvatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: .changeAvatar), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: .logOut), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .greenColor2
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .init(width: 2, height: 2)
        return button
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupNavigationBar()
        setupConstraints()
        updateAvatar()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let tabBar = tabBarController as? MainTabBarViewController {
            tabBar.setMiniPlayerHidden(true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let tabBar = tabBarController as? MainTabBarViewController {
            tabBar.setMiniPlayerHidden(false)
        }
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .magenta.withAlphaComponent(0.1)
    }
    
    private func setupSubviews() {
        changeAvatarButton.addTarget(self, action: #selector(changeAvatarButtonTapped), for: .touchUpInside)
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        
        view.addSubview(imageView)
        view.addSubview(changeAvatarButton)
        view.addSubview(logOutButton)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = String(localized: .settings)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            changeAvatarButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            changeAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 100),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: – Actions
    @objc private func changeAvatarButtonTapped() {
        presenter?.changeAvatarButtonTapped()
    }
    
    @objc private func logOutButtonTapped() {
        presenter?.logOutButtonTapped()
    }
    
    func openImagePicker(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
}

// MARK: – UIImagePickerControllerDelegate
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[.editedImage] as? UIImage
            ?? info[.originalImage] as? UIImage

        guard let image,
              let data = image.jpegData(compressionQuality: 0.8)
        else {
            dismiss(animated: true)
            return
        }
        
        presenter?.didSelectImage(data: data)

        dismiss(animated: true)
    }
}

// MARK: – SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    func showAlert(title: String, message: String) {
        showSimpleAlert(title: title, message: message)
    }
    
    func showPhotoSourceAlert() {
        let alert = UIAlertController(title: String(localized: .choosethesource), message: String(localized: .fromwheretakephoto), preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: String(localized: .camera), style: .default) { [weak self] _ in
            self?.presenter?.cameraSelected()
        }
        
        let galleryAction = UIAlertAction(title: String(localized: .gallery), style: .default) { [weak self] _ in
            self?.presenter?.gallerySelected()
        }
        
        let cancel = UIAlertAction(title: String(localized: .cancel), style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func showGalleryPicker() {
        openImagePicker(source: .photoLibrary)
    }
    
    func showCameraPicker() {
        openImagePicker(source: .camera)
    }
    
    func updateAvatar() {
        if let image = UserManager.shared.avatarImage {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "person.crop.circle.fill")
        }
    }
}
