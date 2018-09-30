//
//  CircleImageHorizontalScrollTableViewCell.swift
//  Hookers
//
//  Created by Kirill Sokolov on 28.09.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class CircleImageHorizontalScrollTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
extension CircleImageHorizontalScrollTableViewCell {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: CircleImageCollectionViewCell.self)
        
        return cell
    }
        
}
