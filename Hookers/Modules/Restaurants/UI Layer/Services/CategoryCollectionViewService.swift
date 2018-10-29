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
    
    func serviceDidChoseCategory(_ service: CategoryCollectionViewService, chosenCategory category: DisplayableCategory)
    
}

final class CategoryCollectionViewService: NSObject {
    
    weak var delegate: CategoryServiceDelegate!
    private var categories : [DisplayableCategory] = []
    private weak var categoryCollectionView: UICollectionView?
    
    init(colletionView: UICollectionView) {
        categoryCollectionView = colletionView
    }
    
    func configurate(with delegate: CategoryServiceDelegate) {
        categoryCollectionView?.delegate = self
        categoryCollectionView?.dataSource = self
        
        categoryCollectionView?.registerReusableCell(cellType:
            MixCategoryCollectionViewCell.self)
        
        self.delegate = delegate
    }
    
    func updateCategories(categories: [DisplayableCategory]) {
        self.categories = categories
        categoryCollectionView?.reloadData()
    }
    
}

extension CategoryCollectionViewService: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: MixCategoryCollectionViewCell.self)
        
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.main.scale;
        
        let category = self.categories[indexPath.row]
        
        cell.nameLabel.text = category.name
        cell.categoryImageView.download(image: category.imageURL, placeholderImage: UIImage(named: "default_category"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        
        delegate?.serviceDidChoseCategory(self, chosenCategory: category)
    }

}

extension CategoryCollectionViewService: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width/3.5
        
        return CGSize(width: width, height: width/1.5)
    }
    
}
