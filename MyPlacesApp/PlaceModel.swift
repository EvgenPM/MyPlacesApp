//
//  PlaceModel.swift
//  MyPlacesApp
//
//  Created by admin on 09.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
struct Place {
    var name: String
    var location: String
    var type: String
    var imagePlace: String
    
    static let testData = ["Y2","Taller","Molly","Buro"]
    
    static func getPlace() -> [Place] {
        var places = [Place]()
        for place in testData {
            places.append(Place(name: place, location: "Spb", type: "Bar", imagePlace: place))
        }
        return places
    }
    
    
}
