//
//  MixListCollectionViewService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 10.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

typealias PhotoAndName = (photo: String, name: String)

protocol MixListServiceDelegate: class {
    
    func serviceDidChoseMix(_ service: MixListCollectionViewService, chosenMix mix: HookahMix)
    
}

final class MixListCollectionViewService: NSObject  {
 
    weak var delegate: MixListServiceDelegate?
    private var mixes: [HookahMix]
    
    init(mixes: [HookahMix]) {
        self.mixes = mixes
    }
    
    func updateMixes(with newMixes: [HookahMix]) {
        mixes = newMixes
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
        cell.mixImageView.image = UIImage(named: mix.imageURL)
        cell.priceLabel.text = String(mix.price) + " " + RestaurantViewController.Constants.grn
        
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
