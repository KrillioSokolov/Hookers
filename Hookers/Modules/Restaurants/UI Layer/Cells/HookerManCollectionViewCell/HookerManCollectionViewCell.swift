//
//  HookerManCollectionViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 16.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class HookerManCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 6
        
        nameLabel.addDefaultSoftShadow()
        likeCount.addDefaultSoftShadow()
        
    }

}
