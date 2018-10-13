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
    
    func orderItemsServiceDidDeleteItem(_ service: OrderItemsTableViewService, deletedItem item: String)
    
}

final class OrderItemsTableViewService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: OrderItemsServiceDelegate!
    var data: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath, cellType: OrderItemTableViewCell.self)
        
        cell.itemNameLabel.text =  "x  " + data[indexPath.row]
        cell.itemNumberLabel.text = "1"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить".localized()) { (action, indexPath) in
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            
            DispatchQueue.main.async {
                self.delegate.orderItemsServiceDidDeleteItem(self, deletedItem: "хуй")
            }
        }
        return [delete]
    }

}
