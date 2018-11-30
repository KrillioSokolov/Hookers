//
//  MixListCollectionViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 10.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

protocol MixListCollectionViewCellDelegate: class {
    
    func didUserFlip(cell: MixListCollectionViewCell, withStatus isFlipped: Bool)
    
}

final class MixListCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mixImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    let descriptionView = MixDescriptionView.instantiateFromNib()
    weak var delegate: MixListCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.addDefaultSoftShadow()
        nameLabel.addDefaultSoftShadow()
        infoButton.addShadowView()

        descriptionView.frame = contentView.bounds
        descriptionView.isHidden = true
        containerView.insertSubview(descriptionView, belowSubview: infoButton)
        
        prepareGestureRecognizers()
    }
    
    private func prepareGestureRecognizers() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(flip(_:)))
        
        leftSwipe.direction = [.left]
        contentView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(flip(_:)))
        
        rightSwipe.direction = [.right]
        contentView.addGestureRecognizer(rightSwipe)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        descriptionView.isHidden = true
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
    
    // MARK: - Actions
    
    @IBAction private func showInfo(_ sender: Any) {
        flip()
    }
    
    @objc private func flip(_ swipe: UISwipeGestureRecognizer) {

        let animationOption: UIViewAnimationOptions = swipe.direction == .left ? .transitionFlipFromRight : .transitionFlipFromLeft

        flip(with: [animationOption])
    }
    
    private func flip(with animateOption: UIViewAnimationOptions = .transitionFlipFromLeft) {
        let isHidden = !descriptionView.isHidden
        
        let isFlipped = isHidden == false
        
        delegate?.didUserFlip(cell: self, withStatus: isFlipped)
        
        UIView.transition(with: contentView, duration: 0.25, options: [animateOption], animations: {
            self.descriptionView.isHidden = isHidden
        }, completion: nil)
    }
    
}

//MARK: - UIStyleGuideRefreshing
extension MixListCollectionViewCell: UIStyleGuideRefreshing {
    
    func refreshUI(withStyleguide styleguide: DesignStyleGuide) {
        containerView.layer.cornerRadius = styleguide.cornerRadius
    }
    
}
