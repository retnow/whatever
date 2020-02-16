//
//  PhotoUpload.swift
//  Whatever
//
//  Created by Retno Widyanti on 5/10/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

protocol ImagePicker
where Self: UIViewController, Self: UIImagePickerControllerDelegate, Self: UINavigationControllerDelegate {
    func pickFromCamera()
    func pickFromLibrary()
    func presentActionSheet()
}

extension ImagePicker {
    func pickFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func pickFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
    
        actionSheet.addAction(
            UIAlertAction(
                title: "Camera",
                style: .default,
                handler: { [weak self] _ -> Void in
                    self?.pickFromCamera()
            }))
        
        actionSheet.addAction(
            UIAlertAction(
                title: "Gallery",
                style: .default,
                handler: { [weak self] _  in
                    self?.pickFromLibrary()
            }))
        
        actionSheet.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}
