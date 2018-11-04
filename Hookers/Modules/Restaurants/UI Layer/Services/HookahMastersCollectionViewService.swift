//
//  HookahMastersCollectionViewService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 01.11.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

protocol HookahMastersServiceDelegate: class {
    
    func serviceDidChoseHookahMaster(_ service: HookahMastersCollectionViewService, chosenHookahMaster hookahMaster: HookahMaster)
    
}

final class HookahMastersCollectionViewService: NSObject  {
    
    var selectedHookahMaster: HookahMaster?
    var hookahMasters: [HookahMaster] = []
    
    private weak var hookahMastersCollectionView: UICollectionView?
    private weak var delegate: HookahMastersServiceDelegate?
    
    init(collectionView: UICollectionView) {
        hookahMastersCollectionView = collectionView
    }
    
    func configurate(with delegate: HookahMastersServiceDelegate) {
        hookahMastersCollectionView?.delegate = self
        hookahMastersCollectionView?.dataSource = self
        hookahMastersCollectionView?.allowsSelection = true
        hookahMastersCollectionView?.registerReusableCell(cellType: HookerManCollectionViewCell.self)
        
        self.delegate = delegate
    }
    
    func updateHookahMasters(hookahMasters: [HookahMaster]) {
        self.hookahMasters = hookahMasters
        
        hookahMastersCollectionView?.reloadData()
    }
    
}

extension HookahMastersCollectionViewService: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hookahMasters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath, cellType: HookerManCollectionViewCell.self)
        
        let master = hookahMasters[indexPath.row]
        
        cell.avatarImageView.download(image: master.imageURL, placeholderImage: nil)
        cell.likeCount.text = String(master.likes)
        cell.nameLabel.text = master.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMaster = hookahMasters[indexPath.row]
        
        selectedHookahMaster = selectedMaster
        delegate?.serviceDidChoseHookahMaster(self, chosenHookahMaster: selectedMaster)
        
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
}

extension HookahMastersCollectionViewService: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width/2 - 10, height: UIScreen.main.bounds.size.height/3)
        
        return size
    }
    
}