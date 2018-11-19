//
//  OrderListTableViewCell.swift
//  Hookers
//
//  Created by Chelak Stas on 10/19/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

class OrdersListTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var hookerImageView: UIImageView!
    @IBOutlet weak var hookerNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeLabel.addDefaultShadow()
        hookerNameLabel.addDefaultShadow()
        
        placeImageView.layer.cornerRadius = 10
        hookerImageView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
        
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
}

extension OrdersListTableViewCell: UIStyleGuideRefreshing {
    
    func refreshUI(withStyleguide styleguide: DesignStyleGuide) {
//        hookerNameLabel.font = styleguide.regularFont(ofSize: 12)
//        placeLabel.font = styleguide.regularFont(ofSize: 12)
//        dateLabel.font = styleguide.regularFont(ofSize: 12)
//        priceLabel.font = styleguide.regularFont(ofSize: 12)
//        statusLabel.font = styleguide.regularFont(ofSize: 12)
    }
    
}
