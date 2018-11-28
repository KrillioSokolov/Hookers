//
//  OrderListTableViewService.swift
//  Hookers
//
//  Created by Chelak Stas on 10/19/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

final class OrdersListTableViewService: NSObject  {
    
    private var orders: [NetworkArchivedOrder] = []
    private var styleguide: DesignStyleGuide!
    private weak var ordersListTableView: UITableView?

    init(tableView: UITableView) {
        ordersListTableView = tableView
    }
    
    func configurate(with styleguide: DesignStyleGuide) {
        ordersListTableView?.delegate = self
        ordersListTableView?.dataSource = self
        ordersListTableView?.backgroundColor = styleguide.backgroundScreenColor
        ordersListTableView?.tableFooterView = UIView()
        ordersListTableView?.separatorStyle = .none
        ordersListTableView?.registerReusableCell(cellType:
            OrdersListTableViewCell.self)
        
        self.styleguide = styleguide
    }
    
    func updateOrdersList(with newList: [NetworkArchivedOrder]) {
        orders = newList
        ordersListTableView?.reloadData()
    }
    
}

extension OrdersListTableViewService: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath, cellType: OrdersListTableViewCell.self)
        
        let order = orders[indexPath.item]
        
        cell.placeImageView.download(image: order.restaurantImageURL, placeholderImage: nil)
        cell.placeLabel.text = order.restaurantName
        cell.hookerImageView.download(image: order.hookahMasterImageURL, placeholderImage: nil)
        cell.hookerNameLabel.text = order.hookahMasterName
        cell.dateLabel.text = order.dueDate
        cell.priceLabel.text = order.amount + HookahMenuViewController.Constants.grn
        cell.statusLabel.text = order.condition
        
        cell.refreshUI(withStyleguide: styleguide)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

