//
//  OrderListTableViewCell.swift
//  Hookers
//
//  Created by Chelak Stas on 10/19/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class OrdersListTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private(set) weak var placeImageView: UIImageView!
    @IBOutlet private(set) weak var hookerImageView: UIImageView!
    @IBOutlet private(set) weak var hookerNameLabel: UILabel!
    @IBOutlet private(set) weak var placeLabel: UILabel!
    @IBOutlet private(set) weak var dateLabel: UILabel!
    @IBOutlet private(set) weak var containerView: UIView!
    @IBOutlet private(set) weak var priceLabel: UILabel!
    @IBOutlet private(set) weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeLabel.addDefaultSoftShadow()
        hookerNameLabel.addDefaultSoftShadow()
        containerView.addShadowView()
        containerView.layer.borderWidth = 1
    }
    
}

extension OrdersListTableViewCell: UIStyleGuideRefreshing {
    
    func refreshUI(withStyleguide styleguide: DesignStyleGuide) {
        placeImageView.layer.cornerRadius = styleguide.cornerRadius
        hookerImageView.layer.cornerRadius = styleguide.cornerRadius
        containerView.layer.cornerRadius = styleguide.cornerRadius
        containerView.backgroundColor = styleguide.backgroundScreenColor
    }
    
}
