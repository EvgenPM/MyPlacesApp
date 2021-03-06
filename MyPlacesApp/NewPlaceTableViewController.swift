//
//  NewPlaceTableViewController.swift
//  MyPlacesApp
//
//  Created by admin on 12.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
import Cosmos

class NewPlaceTableViewController: UITableViewController {
    
    //var newPlace = Place()
    var currentPlace: Place?
    var imageIsChanged = false
    var currentRating = 0.0
    
    @IBOutlet weak var imageOfPlace: UIImageView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var saveOutlet: UIBarButtonItem!
    @IBOutlet weak var placeType: UITextField!
  
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cosmosView.didTouchCosmos = { rating in
            self.currentRating = rating
        }
       
   /* download test data
        DispatchQueue.main.async {
            self.newPlace.savePlaces()
        }
  */
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0,
                                                         width: tableView.frame.size.width, height: 1))
        saveOutlet.isEnabled = true
        setupEditScreen()
        
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
    func savePlace() {
        
        var image:UIImage?
        if imageIsChanged {
            image = imageOfPlace.image
        } else {
            image = #imageLiteral(resourceName: "noimage")
        }
        
        let imageData = image?.pngData()
        let newPlace = Place(name: placeName.text!, location: placeLocation.text,
                             type: placeType.text, imageData: imageData,rating: currentRating)
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
                currentPlace?.rating = newPlace.rating
            }
        } else {
                StorageManager.saveObject(_place: newPlace)
}
        
    }
    
      private func setupEditScreen() {
            if currentPlace != nil {
            
                setupNavigationBar()
                imageIsChanged = true
                
                guard let data = currentPlace?.imageData,let image = UIImage(data: data) else { return }
                imageOfPlace.image = image
                imageOfPlace.contentMode = .scaleAspectFill
                placeName.text = currentPlace?.name
                placeType.text = currentPlace?.type
                placeLocation.text = currentPlace?.location
                cosmosView.rating = currentPlace!.rating
            }
        }
        
          private func setupNavigationBar() {
            navigationItem.leftBarButtonItem = nil
            title = currentPlace?.name
            saveOutlet.isEnabled = true
        }
        
      //  newPlace = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, restImage: nil, image:image)
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

