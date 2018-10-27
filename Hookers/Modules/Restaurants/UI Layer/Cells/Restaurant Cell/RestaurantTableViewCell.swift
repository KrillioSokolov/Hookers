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

protocol RestaurantListTableViewCell {
    
    var presentImageView: UIImageView! { get }
    var nameLabel: UILabel! { get }
    var containerView: UIView! { get }
    var distanceLabel: UILabel! { get }
    var likeCountLabel: UILabel! { get }
    var delegate: RestaurantTableViewCellDelegate! { get set }
 
}

final class RestaurantTableViewCell: UITableViewCell, RestaurantListTableViewCell, NibReusable {
    
    @IBOutlet weak var presentImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet private weak var infoButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    weak var delegate: RestaurantTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func restaurantInfo(_ sender: Any) {
        delegate.didTapRestaurantInfoButton(on: self)
    }
}
