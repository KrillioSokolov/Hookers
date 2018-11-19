//
//  OrderListTableViewService.swift
//  Hookers
//
//  Created by Chelak Stas on 10/19/18.
//  Copyright © 2018 Kirill Sokolov. All rights reserved.
//

import UIKit

enum OrderStatus {
    case ordered
    case needPayments
    case checking
    case inProgress
    case needRate
    case done
    
    func color() -> UIColor {
        switch self {
        case .checking, .inProgress, .ordered, .needRate: return .blue
        case .needPayments: return .red
        case .done: return .green
        }
    }
    
    func string() -> String {
        switch self {
        case .ordered: return "Заказан"
        case .needPayments: return "Оплата"
        case .checking: return "Проверка"
        case .inProgress: return "Выполняется"
        case .needRate: return "Оценка"
        case .done: return "Выполнен"
        }
    }
}

typealias OrderListTableViewModel = (placeName: String, placePhoto: String, date: String, hookerName: String, hookerPhoto: String, price: String, positionsCount: String, status: OrderStatus)

protocol OrdersListServiceDelegate: class {

//    func serviceDidChoseOrder(_ service: OrderListTableViewService, chosenOrder orderName: OrderListTableViewModel)
}

final class OrdersListTableViewService: NSObject  {
    
    private var orders: [NetworkOrder] = []
    private var styleGuide: DesignStyleGuide!
    private weak var ordersListTableView: UITableView?
    private weak var delegate: OrdersListServiceDelegate?

    init(tableView: UITableView) {
        ordersListTableView = tableView
    }
    
    func configurate(with delegate: OrdersListServiceDelegate, styleGuide: DesignStyleGuide) {
        ordersListTableView?.delegate = self
        ordersListTableView?.dataSource = self
        
        ordersListTableView?.registerReusableCell(cellType:
            OrdersListTableViewCell.self)
        
        self.delegate = delegate
        self.styleGuide = styleGuide
    }
    
    func updateOrdersList(with newList: [NetworkOrder]) {
        self.orders = newList
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
        cell.priceLabel.text = order.amount

        cell.statusLabel.text = order.condition
        
        cell.refreshUI(withStyleguide: styleGuide)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

