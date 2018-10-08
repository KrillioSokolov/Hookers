//
//  RestaurantTableViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 28.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

protocol RestaurantTableViewCellDelegate: class {
    
    func didTapRestaurantInfoButton(on cell: UITableViewCell)
    
}

final class RestaurantTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var presentImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoButton: UIButton!
    
    weak var delegate: RestaurantTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func restaurantInfo(_ sender: Any) {
        delegate.didTapRestaurantInfoButton(on: self)
    }
}
