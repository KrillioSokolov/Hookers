//
//  UICollectionView+Reusable.swift
//  Hookers
//
//  Created by Hookers on 12/26/18.
//  Copyright © 2017 Hookers. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: UICollectionViewCell
    
    /** Register a NIB-Based `UICollectionViewCell` subclass (conforming to `NibReusable`) */
    final func registerReusableCell<T: UICollectionViewCell>(cellType: T.Type) where T: NibReusable {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /** Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`) */
    final func registerReusableCell<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /** Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type */
    final func dequeueReusableCell<T: UICollectionViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = dequeueReusableCell(
                withReuseIdentifier: cellType.reuseIdentifier,
                for: indexPath
                ) as? T else {
                    fatalError(
                        "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) "
                            + "matching type \(cellType.self). "
                            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                            + "and that you registered the cell beforehand"
                    )
                    
            }
            
            return cell
    }
    
    // MARK: UICollectionReusableView
    
    /**
     Register a NIB-Based `UICollectionReusableView` subclass (conforming to `NibReusable`) as a Supplementary View
     */
    final func registerReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, viewType: T.Type)
        where T: NibReusable {
            register(
                viewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier
            )
    }
    
    /** Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View */
    final func registerReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, viewType: T.Type)
        where T: Reusable {
            register(
                viewType.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier
            )
    }
    
    /** Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type */
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (elementKind: String, indexPath: IndexPath, viewType: T.Type = T.self) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
            ) as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier)"
                        + " matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the supplementary view beforehand"
                )
        }
        
        return view
    }
    
}

