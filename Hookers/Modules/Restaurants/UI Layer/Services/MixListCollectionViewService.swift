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
    
    func serviceDidChoseMix(_ service: MixListCollectionViewService, chosenMixName mixName: String)
    
}

final class MixListCollectionViewService: NSObject  {
 
    weak var delegate: MixListServiceDelegate?
    
    var data: [PhotoAndName] = [("lemon_pie", "Лемонный пирог"), ("mishki", "Мишки гамми"), ("vata", "Сладкая вата"), ("moxito", "Мохито"), ("pina-colada", "Пина колада"), ("myata_shoko", "Мятный шоколад"), ("spiced_tea", "Пряный чай"), ("cola_lemon", "Двойной кайф"), ("mafin", "Черничный мафин")]
    
}

extension MixListCollectionViewService: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: MixListCollectionViewCell.self)
        
        let data = self.data[indexPath.row]
        
        cell.nameLabel.text = data.name
        cell.mixImageView.image = UIImage(named: data.photo)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mix = data[indexPath.row]
        
        delegate?.serviceDidChoseMix(self, chosenMixName: mix.name)
    }
    
}

extension MixListCollectionViewService: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width/2 - 10, height: UIScreen.main.bounds.size.height/3)
        
        return size
    }
    
}
