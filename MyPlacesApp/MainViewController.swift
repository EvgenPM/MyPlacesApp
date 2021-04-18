//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by admin on 07.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    var places: Results<Place>!
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }
 

      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0: places.count
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]
        
        cell.nameLabel?.text = place.name
        cell.typeLabel.text = place.type
        
        /*
        if place.image == nil {
            cell.imageOfPlace.image = UIImage(named: place.restImage!)
        } else {
            cell.imageOfPlace.image = place.image
        }
       */
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        cell.locationLabel.text = place.location
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true


        return cell
    }
    

   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindSegue(_segue: UIStoryboardSegue) {
        guard let newPlaceVC = _segue.source as? NewPlaceTableViewController else {return}
        newPlaceVC.saveNewPlace()
      //  places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
        }
}


