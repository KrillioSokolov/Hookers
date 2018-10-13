//
//  MixListCollectionViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 10.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class MixListCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mixImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.addDefaultSoftShadow()
        infoButton.addShadowView()
        containerView.layer.cornerRadius = 6
    }

}
