//
//  UIImageView+SDWebImage.swift
//  Hookers
//
//  Created by Sokolov Kirill on 2/2/18.
//  Copyright © 2018 Приват24. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func download(image url: String, placeholderImage: UIImage?) {
        guard let imageURL = URL(string: url) else {
            self.image = placeholderImage
            return
        }
        self.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
    }
    
    func cancelCurrentImageLoad() {
        self.sd_cancelCurrentImageLoad()
    }
    
}
