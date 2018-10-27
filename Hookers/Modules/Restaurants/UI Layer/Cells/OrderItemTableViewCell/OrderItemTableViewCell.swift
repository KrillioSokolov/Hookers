//
//  OrderItemTableViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 12.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class OrderItemTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
