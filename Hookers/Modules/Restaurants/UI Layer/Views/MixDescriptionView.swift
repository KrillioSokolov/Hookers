//
//  MixDescriptionView.swift
//  Hookers
//
//  Created by Stas Chelak on 11/27/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

class MixDescriptionView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var glassView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.addDefaultSoftShadow()
        descriptionLabel.addDefaultSoftShadow()
    }
    
}
