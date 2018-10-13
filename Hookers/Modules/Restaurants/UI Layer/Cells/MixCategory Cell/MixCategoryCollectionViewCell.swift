//
//  MixCategoryCollectionViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 09.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class MixCategoryCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 6
        
        nameLabel.addDefaultSoftShadow()       
    }

}
