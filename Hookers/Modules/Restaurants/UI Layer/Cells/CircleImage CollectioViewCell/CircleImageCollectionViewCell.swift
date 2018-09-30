//
//  CircleImageCollectionViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 30.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class CircleImageCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var maskImageView: UIImageView!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
