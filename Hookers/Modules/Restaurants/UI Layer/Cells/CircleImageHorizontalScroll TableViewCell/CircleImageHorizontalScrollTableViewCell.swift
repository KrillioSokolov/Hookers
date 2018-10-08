//
//  CircleImageHorizontalScrollTableViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 28.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class CircleImageHorizontalScrollTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellImage: UIImage!
    var mixName: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerReusableCell(cellType: CircleImageCollectionViewCell.self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
        
}
    
extension CircleImageHorizontalScrollTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 78, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: CircleImageCollectionViewCell.self)
        
        cell.circleImageView.image = cellImage
        cell.nameLabel.text = mixName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.3
    }
    
    
        
}
