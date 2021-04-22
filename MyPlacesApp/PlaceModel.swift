//
//  PlaceModel.swift
//  MyPlacesApp
//
//  Created by admin on 09.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import RealmSwift
class Place:Object {
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var restImage: String?
    @objc dynamic var imageData: Data?
    // add new var for sorting
    @objc dynamic var date = Date()
    @objc dynamic var rating = 0.0
    
    
    convenience init(name: String,location: String?,type: String?,imageData: Data?, rating: Double?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
        self.rating = rating!
    }
    
    /* test array and method for its downloading
    let testData = ["Y2","Taller","Molly","Buro"]
    
    func savePlaces() {
    
        
    let image = UIImage(named: place)
    guard let imageData = image?.pngData() else { return }
        
    let newPlace = Place()
        
    newPlace.name = place
    newPlace.location = "SPb"
    newPlace.type = "Bar"
    newPlace.imageData = imageData
      
        StorageManager.saveObject(_place: newPlace)
        }
    }
    */
}
