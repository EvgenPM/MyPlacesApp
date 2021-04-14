//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by admin on 07.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var places = Place.getPlace()
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }
 

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return places.count
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel?.text = places[indexPath.row].name
        cell.imageOfPlace?.image = UIImage(named: places[indexPath.row].restImage!)
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true


        return cell
    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindSegue(_segue: UIStoryboardSegue) {
        guard let newPlaceVC = _segue.source as? NewPlaceTableViewController else {return}
        newPlaceVC.saveNewPlace()
        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
        }
}


