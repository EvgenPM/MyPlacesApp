//
//  NewPlaceTableViewController.swift
//  MyPlacesApp
//
//  Created by admin on 12.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
                }
                let photoAction = UIAlertAction(title: "Photo", style: .default) { _ in
                    self.chooseImagePicker(source: .photoLibrary)
            }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    actionSheet.addAction(cameraAction)
                    actionSheet.addAction(photoAction)
                    actionSheet.addAction(cancelAction)
                    present(actionSheet, animated: true)
            }
     else {
            view.endEditing(true)
        }
    }
}

extension NewPlaceTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension NewPlaceTableViewController {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
}

