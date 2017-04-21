//
//  ProvileViewController+Delegates.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 12/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation
import UIKit
import Parse
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imageTapped(_ img: AnyObject) {
        let alert = UIAlertController(title: "Upload Image", message: "Choose the source", preferredStyle: .actionSheet )

        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.chooseImage(false)
            }
        }))

        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (_) -> Void in
            self.chooseImage(true)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))

        self.present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismiss(animated: true, completion: nil)

        if let selectedImage = UIImagePNGRepresentation(image) {

            self.avatar.image = image
            self.spinner.stopAnimating()

            Facade.shared.updateUserAvatar(image: selectedImage, onSuccess: { (success) in
                print(success)
            }, onFail: { (error) in
                print(error)
            })

        }
    }

    func chooseImage(_ lib: Bool) {
        let pickerController = UIImagePickerController()

        pickerController.delegate = self

        if lib {
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        } else {
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.cameraDevice = .rear
        }

        pickerController.allowsEditing = true

        self.present(pickerController, animated: true, completion: nil)
    }
}
