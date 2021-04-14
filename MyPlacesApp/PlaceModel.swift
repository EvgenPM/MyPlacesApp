//
//  PlaceModel.swift
//  MyPlacesApp
//
//  Created by admin on 09.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
struct Place {
    var name: String
    var location: String?
    var type: String?
    var restImage: String?
    var image:UIImage?
    
    static let testData = ["Y2","Taller","Molly","Buro"]
    
    static func getPlace() -> [Place] {
        var places = [Place]()
        for place in testData {
            places.append(Place(name: place, location: "Spb", type: "Bar", restImage: place, image: nil))
        }
        return places
    }
    
    
}
