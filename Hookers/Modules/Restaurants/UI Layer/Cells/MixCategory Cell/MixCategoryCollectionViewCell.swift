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
    @IBOutlet weak var selectedLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 6
        
        nameLabel.addDefaultSoftShadow()
        
        selectedLineView.isHidden = true
        selectedLineView.layer.cornerRadius = 1
        selectedLineView.addShadowView()
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: CollectionViewTransformConstants.scaleFactor, y: CollectionViewTransformConstants.scaleFactor)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.categoryImageView.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                    self.selectedLineView.isHidden = false
                    self.selectedLineView.transform = CGAffineTransform(scaleX: 5, y: 1);
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                    self.selectedLineView.transform = CGAffineTransform(scaleX: 0, y: 1);
                }, completion: nil)
            }
        }
    }

}
