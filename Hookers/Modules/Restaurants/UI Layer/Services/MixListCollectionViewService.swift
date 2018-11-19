//
//  MixListCollectionViewService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 10.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

protocol MixListServiceDelegate: class {
    
    func serviceDidChoseMix(_ service: MixListCollectionViewService, chosenMix mix: HookahMix)
    
}

final class MixListCollectionViewService: NSObject  {
 
    private weak var delegate: MixListServiceDelegate?
    private var mixes: [HookahMix] = []
    private weak var mixListCollectionView: UICollectionView?
    private var styleguide: DesignStyleGuide!
    
    init(collectionView: UICollectionView) {
        mixListCollectionView = collectionView
    }
    
    func configurate(with delegate: MixListServiceDelegate, styleguide: DesignStyleGuide) {
        mixListCollectionView?.delegate = self
        mixListCollectionView?.dataSource = self
        mixListCollectionView?.registerReusableCell(cellType: MixListCollectionViewCell.self)
        
        self.delegate = delegate
        self.styleguide = styleguide
    }
    
    func updateMixes(with newMixes: [HookahMix]) {
        mixes = newMixes
        mixListCollectionView?.reloadData()
    }
 
}

extension MixListCollectionViewService: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mixes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: MixListCollectionViewCell.self)
        
        let mix = mixes[indexPath.row]
        
        cell.nameLabel.text = mix.name
        cell.mixImageView.download(image: mix.imageURL, placeholderImage: UIImage(named: "default_mix"))
        cell.priceLabel.text = String(mix.price) + " " + HookahMenuViewController.Constants.grn
        cell.descriptionLabel.text = mix.description
        cell.glassView.backgroundColor = styleguide.glassColor
        
        let tobacos = mix.tabacco.map({$0.brand}).joined(separator: ", ")
        
        cell.tabaccoLabel.text = tobacos
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.serviceDidChoseMix(self, chosenMix: mixes[indexPath.row])
    }
    
}

extension MixListCollectionViewService: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width/2 - 10, height: UIScreen.main.bounds.size.height/3)
        
        return size
    }
    
}
