//
//  CustomTableViewCell.swift
//  MyPlacesApp
//
//  Created by admin on 08.04.2021.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
import Cosmos
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfPlace: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!{
        didSet {
            cosmosView.settings.updateOnTouch = false
        }
    }
    
}
