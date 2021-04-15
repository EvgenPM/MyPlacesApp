//
//  NewPlaceTableViewController.swift
//  MyPlacesApp
//
//  Created by admin on 12.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    var newPlace: Place?
    var imageIsChanged = false
    @IBOutlet weak var imageOfPlace: UIImageView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var saveOutlet: UIBarButtonItem!
    @IBOutlet weak var placeType: UITextField!
  
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        saveOutlet.isEnabled = true
       // placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
                }
            cameraAction.setValue(cameraIcon, forKey: "Image")
            cameraAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

                let photoAction = UIAlertAction(title: "Photo", style: .default) { _ in
                    self.chooseImagePicker(source: .photoLibrary)
            }
            photoAction.setValue(photoIcon, forKey: "Image")
            photoAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
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
    func saveNewPlace() {
        var image:UIImage?
        if imageIsChanged {
            image = imageOfPlace.image
        } else {
            image = #imageLiteral(resourceName: "noimage")
        }
        
        
        newPlace = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, restImage: nil, image:image)
    }
}

extension NewPlaceTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  /*  @objc func textFieldChanged() {
        if (placeName.text?.isEmpty = false)! {
            saveOutlet.isEnabled = true
        } else {
            saveOutlet.isEnabled = false
            
        }
    } */
}
extension NewPlaceTableViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        imageOfPlace.image = info[.editedImage] as? UIImage
        imageOfPlace.contentMode = .scaleAspectFill
        imageOfPlace.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
        
    }
}

