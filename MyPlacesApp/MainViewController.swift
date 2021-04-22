//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by admin on 07.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    var places: Results<Place>!
    var searchResult: Results<Place>!
    var reverseSorting = true
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
        
 // setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
 

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return searchResult.count
        }
        return places.isEmpty ? 0: places.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        var place = Place()
        if isFiltering {
            place = searchResult[indexPath.row]
        } else {
            place = places[indexPath.row]
        }
      
        
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
        cell.cosmosView.rating = place.rating


        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = places[indexPath.row]
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

   
    
    // MARK: - Navigation

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let place: Place
            if isFiltering {
                   place = searchResult[indexPath.row]
               } else {
                   place = places[indexPath.row]
               }
            let newPlaceVC = segue.destination as! NewPlaceTableViewController
            newPlaceVC.currentPlace = place
        }
    }
    
    @IBAction func unwindSegue(_segue: UIStoryboardSegue) {
        guard let newPlaceVC = _segue.source as? NewPlaceTableViewController else {return}
        newPlaceVC.savePlace()
      //  places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
        }
    
    @IBAction func sortButtonAction(_ sender: UIBarButtonItem) {
        reverseSorting.toggle()
        if reverseSorting {
            sortButton.image = #imageLiteral(resourceName: "ZA")
        } else {
            sortButton.image = #imageLiteral(resourceName: "AZ")
        }
        sorting()
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
      sorting()
    }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: reverseSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: reverseSorting)
        }
        tableView.reloadData()
        
    }
    
}


extension MainViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        resultForSearch(searchController.searchBar.text!)
    }
    
    func resultForSearch(_ searchText: String)  {
        searchResult = places.filter("name CONTAINS [c] %@ OR location CONTAINS [c] %@", searchText,searchText)
        tableView.reloadData()
        
    }
}



