//
//  MainViewController.swift
//  MyPlacesApp
//
//  Created by admin on 07.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let restaurantNames = ["KetchUp Burgers","Molly","Taller","2 палочки","Buro"]

    override func viewDidLoad() {
        super.viewDidLoad()


    }
 

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return restaurantNames.count
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: restaurantNames[indexPath.row])


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

}

