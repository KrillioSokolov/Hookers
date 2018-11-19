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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var glassView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tabaccoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.addDefaultSoftShadow()
        nameLabel.addDefaultSoftShadow()
        infoButton.addShadowView()
        descriptionLabel.addDefaultSoftShadow()
        tabaccoLabel.addDefaultSoftShadow()
        containerView.layer.cornerRadius = 6
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoView.isHidden = true
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    self.blurView.effect = UIBlurEffect.init(style: .dark)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.blurView.effect = nil
                }, completion: nil)
            }
        }
    }
    
    @IBAction private func showInfo(_ sender: Any) {
        let isHidden = infoView.isHidden
        
        let animation: UIView.AnimationOptions = isHidden ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        UIView.transition(with: contentView, duration: 0.4, options: animation, animations: {
            self.infoView.isHidden = !isHidden
        }, completion: nil)
    }
    
    
    
}
