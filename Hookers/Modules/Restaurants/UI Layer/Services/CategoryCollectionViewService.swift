//
//  CategoryCollectionViewService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 10.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

protocol CategoryServiceDelegate: class {
    
    func serviceDidChoseCategory(_ service: CategoryCollectionViewService, chosenCategory category: String)
    
}

final class CategoryCollectionViewService: NSObject {
    
    weak var delegate: CategoryServiceDelegate!
    
    var data: [PhotoAndName] = [("sladkiy", "Сладкий"), ("myata", "Мятный"), ("kisliy", "Кислый"), ("fruktoviy", "Фруктовый"), ("exotic", "Экзотика")]
    
}

extension CategoryCollectionViewService: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: MixCategoryCollectionViewCell.self)
        
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.main.scale;
        
        let data = self.data[indexPath.row]
        
        cell.nameLabel.text = data.name
        cell.categoryImageView.image = UIImage(named: data.photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = data[indexPath.row]
        
        delegate?.serviceDidChoseCategory(self, chosenCategory: category.name)
    }
    
}

extension CategoryCollectionViewService: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width/3.5, height: 70)
        
        return size
    }
    
}
