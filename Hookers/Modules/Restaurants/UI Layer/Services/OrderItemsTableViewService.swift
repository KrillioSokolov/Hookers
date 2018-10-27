//
//  OrderItemsTableViewService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 12.10.2018.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import Foundation
import UIKit

protocol OrderItemsServiceDelegate: class {
    
    func orderItemsServiceDidDeleteItem(_ service: OrderItemsTableViewService, deletedItem item: HookahMix)
    
}

final class OrderItemsTableViewService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: OrderItemsServiceDelegate!
    var orderedMixes: [HookahMix] = []
    
    func addMixToOrder(_ mix: HookahMix) {
        orderedMixes.insert(mix, at: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedMixes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath, cellType: OrderItemTableViewCell.self)
        
        let mix = orderedMixes[indexPath.row]
        
        cell.itemNameLabel.text = mix.name
        cell.orderImageView.image = UIImage(named: mix.imageURL)
        cell.priceLabel.text = String(mix.price) + " " + RestaurantViewController.Constants.grn
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить".localized()) { (action, indexPath) in
            let deletedMix = self.orderedMixes[indexPath.row]
            
            self.orderedMixes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            
            DispatchQueue.main.async {
                self.delegate.orderItemsServiceDidDeleteItem(self, deletedItem: deletedMix)
            }
        }
        return [delete]
    }

}
